package jp.seagirl.containers
{
	import mx.containers.ViewStack;
	import mx.core.UIComponent;

	public class GeniusViewStack extends ViewStack
	{
		public function GeniusViewStack()
		{
			super();
		}
		
		public function selectByClassName(className:String):void
		{
			var view:UIComponent;
			
			getChildren().forEach
			(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == className)
						view = element;
				}
			);
			
			if (view)
			{
				var oldIndex:int = selectedIndex;
				var newIndex:int = getChildIndex(view);
				
				selectedIndex = newIndex;
			}
			else
			{
				throw new Error("Couldn't find " + className);
			}
		}
		
	}
}