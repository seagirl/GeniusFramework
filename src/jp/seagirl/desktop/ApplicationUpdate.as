/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 seagirl
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

package jp.seagirl.desktop
{
	import flash.desktop.Updater;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestMethod;
	
	import jp.seagirl.genius.business.URLLoaderService;
	import jp.seagirl.filesystem.FileIO;
	
	import mx.utils.UIDUtil;
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 * アップデート処理が完了すると発行されます。
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * アップデート時に、新しいAIRファイルをダウンロードしている間に発行されます。
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]
	
	
	
	/**
	 * AIRアプリケーションのアップデート処理をするためのクラス
	 * 
	 * @author yoshizu
	 * 
	 * @example アップデート処理の例
	 * <listing version="3.0">
package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    
    import jp.s2factory.yoshizu.desktop.ApplicationUpdate;

    public class ApplicationUpdateExample extends Sprite
    {
        public static const VERSION_FILE:String = 'http://www.s2factory.co.jp/version.xml';
        public static const AIR_FILE:String = 'http://www.s2factory.co.jp/dist/update.air';
        public static const SAVE_AS:String = 'updates/update.air';
        
        public function ApplicationUpdateExample()
        {
            addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
            
            updateManager = new ApplicationUpdate();
            updateManager.addEventListener(ProgressEvent.PROGRESS, updateManagerProgressHandler);
            updateManager.addEventListener(Event.COMPLETE, updaterCompleteHandler);
            updateManager.update(VERSION_FILE, AIR_FILE, SAVE_AS);
        }
        
        private var updateManager:ApplicationUpdate;
        
        private function addToStageHandler(event:Event):void
        {
            stage.frameRate = 30;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }
        
        private function updateManagerProgressHandler(event:ProgressEvent):void
        {
            trace('progress: ', event.bytesLoaded, '/', event.bytesTotal);
        }
        
        private function updaterCompleteHandler(event:Event):void
        {
            trace('complete: ')
        }
    }
}
	 * </listing>
	 */	
	public class ApplicationUpdate extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 * 
		 * @param debug デバッグモードにする場合は引数に1を与えます。
		 * デバッグモードでは、このインスタンスが新しいAIRファイルをダウンロードしてきたところで、
		 * flash.desktop.Updateクラスのupdateメソッドを実際には呼ばずに完了イベントを送出します。
		 * これはアプリケーションをadlで動かしている時に、このメソッドを呼ぶことが出来ない
		 * （ランタイムエラーが発生する）のを防ぐ目的で用います。
		 */		
		public function ApplicationUpdate(debug:int = 0)
		{
			this.debug = debug;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */	
		private var debug:int;
		
		/**
		 * @private 
		 */			
		private var checkUpdateResponder:CheckUpdateResponder;
		
		/**
		 * @private 
		 */	
		private var downloadAIRResponder:DownloadAIRResponder;
		
		/**
		 * @private 
		 */	
		private var versionFile:String;
		
		/**
		 * @private 
		 */	
		private var airFile:String;
		
		/**
		 * @private 
		 */	
		private var saveAs:String;
		
		/**
		 * @private 
		 */	
		private var newVersion:String;
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * アップデート情報をチェックし、必要があればアップデート処理を実行します。
		 * 
		 * @param versionFile バージョン情報が記載されているファイルへのURL
		 * @param airFile 新しいAIRファイルへのURL
		 * @param saveAs ダウンロードした新しいAIRファイルの保存先であるローカルストレージ内におけるパス
		 */		
		public function update(versionFile:String, airFile:String, saveAs:String):void
		{
			this.versionFile = versionFile;
			this.airFile = airFile;
			this.saveAs = saveAs;
			check();
		}
		
		/**
		 * @private 
		 */	
		private function check():void
		{
			checkUpdateResponder = new CheckUpdateResponder();
			checkUpdateResponder.addEventListener(Event.COMPLETE, checkUpdateResponderComplateHandler);
			
			var service:URLLoaderService = new URLLoaderService();
			service.url = versionFile;
			service.method = URLRequestMethod.GET;
			service.addResponder(checkUpdateResponder);
			service.send({ 'no-cache': UIDUtil.createUID() });
		}
		
		/**
		 * @private 
		 */	
		private function download():void
		{
			downloadAIRResponder = new DownloadAIRResponder(saveAs);
			downloadAIRResponder.addEventListener(ProgressEvent.PROGRESS, downloadAIRResponderProgressHandler);
			downloadAIRResponder.addEventListener(Event.COMPLETE, downloadAIRResponderComplateHandler);
			
			var service:URLLoaderService = new URLLoaderService();
			service.url = airFile;
			service.dataFormat = URLLoaderDataFormat.BINARY;
			service.method = URLRequestMethod.GET;
			service.addResponder(downloadAIRResponder);
			service.send({ 'no-cache': UIDUtil.createUID() });
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */	
		private function checkUpdateResponderComplateHandler(event:ApplicationUpdateEvent):void
		{
			if (event.needUpdating)
			{
				this.newVersion = event.newVersion;
				download();
			}
			else
				dispatchEvent(event);
		}
		
		/**
		 * @private 
		 */	
		private function downloadAIRResponderProgressHandler(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * @private 
		 */	
		private function downloadAIRResponderComplateHandler(event:ApplicationUpdateEvent):void
		{
			var fileIO:FileIO = new FileIO();
			var file:File = fileIO.readFile(saveAs);

			if (debug === 0)
			{
				var updater:Updater = new Updater();
				updater.update(file, newVersion); 	
			}
			
			dispatchEvent(event); 
		}

	}
}