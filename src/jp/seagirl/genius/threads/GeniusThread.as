package jp.seagirl.genius.threads
{
	import jp.seagirl.genius.controllers.ApplicationDelegate;
	import jp.seagirl.genius.core.Context;
	
	import org.libspark.thread.Thread;

	public class GeniusThread extends Thread
	{
		public function GeniusThread()
		{
			super();
			
			initialize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 汎用的なデータオブジェクトです.
		 */		
		protected var data:Object;
		
		protected var context:Context;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		private function initialize():void
		{
			context = ApplicationDelegate.sharedApplicationDelegate().context;
		}
		
		/**
		 * 汎用的なデータを追加するためのメソッドです。
		 * @param data
		 * @return  
		 */		
		public function addData(data:Object):GeniusThread
		{
			this.data = data;
			
			return this;
		}
		
		/**
		 * 汎用的なデータを保持しながら、Thread を開始するためのメソッドです.
		 * @param data 汎用的なデータオブジェクト
		 */		
		public function startWithData(data:Object):void
		{
			this.data = data;
			
			start();
		}
		
	}
}