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
			var child:UIComponent;
			
			getChildren().forEach
			(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == className)
						child = element;
				}
			);
			
			if (child)
			{
				var oldIndex:int = selectedIndex;
				var newIndex:int = getChildIndex(child);
				
				selectedIndex = newIndex;
			}
			else
			{
				selectedIndex = 0;
			}
		}
		
	}
}