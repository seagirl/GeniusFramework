package jp.seagirl.genius.controllers
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import jp.seagirl.genius.core.Context;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class Controller implements IMXMLObject
	{
		public function Controller()
		{
		}
		
		public var context:Context;
		public var viewClass:Class;
		
		protected function getViewClass():Class
		{
			var className:String = getQualifiedClassName(this['view']);				
			var viewClassName:String = className.replace(/::/g, '.');
			var viewClass:Class;
			
			try
			{
				viewClass = getDefinitionByName(viewClassName) as Class
			}
			catch(e:Error)
			{
				viewClass = null;
			}
			
			return viewClass;
			
		}

		public function initialized(document:Object, id:String):void
		{
			if (!hasOwnProperty('view'))
				throw new Error("対応する View が見つかりません。");
			
			this['view'] = document;
			
			viewClass = getViewClass();
			
			this['view'].addEventListener(FlexEvent.PREINITIALIZE, view_preinitializeHandler);
			this['view'].addEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			this['view'].addEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
		}
		
		protected function preinitialize():void
		{
			
		}
		
		protected function initialize():void
		{
			
		}
		
		protected function creationComplete():void
		{
			
		}
		
		protected function update():void
		{
			
		}
		
		/**
		 * FlexEvent.PREINITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function view_preinitializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.PREINITIALIZE, view_preinitializeHandler);
			
			preinitialize();
		}
		
		/**
		 * FlexEvent.INITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function view_initializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			
			initialize();
		}
		 
		/**
		 * FlexEvent.CREATION_COMPLETEで呼ばれるハンドラ
		 * @param event 
		 */		 
		protected function view_creationCompleteHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
			
			creationComplete();
		}
		
	}
}