package jp.seagirl.genius.views
{
	import mx.core.Window;
	import mx.events.AIREvent;
	import mx.events.FlexEvent;

	public class WindowBase extends Window
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function WindowBase()
		{
			super();
			addEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
			addEventListener(FlexEvent.INITIALIZE, initializeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			addEventListener(AIREvent.WINDOW_ACTIVATE, activateHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 初期化処理の最後に呼び出されます。
		 * このメソッドをオーバーライドして、実装して下さい。
		 */		
		protected function initializeView():void
		{
			
		}
		
		/**
		 * ビューを更新します。
		 * ビューがViewStackの子供の場合、
		 * 選択されるとこのメソッドが呼ばれます。 
		 */		
		protected function updateView():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * FlexEvent.PREINITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function preinitializeHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
		}
		
		/**
		 * FlexEvent.INITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function initializeHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.INITIALIZE, initializeHandler);
			initializeView();
		}
		 
		/**
		 * FlexEvent.CREATION_COMPLETEで呼ばれるハンドラ
		 * @param event 
		 */		 
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		protected function activateHandler(event:AIREvent):void
		{
			updateView();
		}
		
	}
}