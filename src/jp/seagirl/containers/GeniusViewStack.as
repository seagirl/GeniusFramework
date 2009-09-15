package jp.seagirl.containers
{
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import jp.seagirl.genius.events.GeniusEvent;
	import jp.seagirl.genius.threads.ChangeStateThread;
	
	import mx.containers.ViewStack;
	import mx.core.UIComponent;

	public class GeniusViewStack extends ViewStack
	{
		public function GeniusViewStack()
		{
			super();
		}
		
		public function selectViewByClassName(className:String):void
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
				
				if (oldIndex == newIndex)
				{
					view.dispatchEvent(new GeniusEvent(GeniusEvent.UPDATE_PAGE));
				}
				else
				{
					selectedIndex = newIndex;	
				}
			}
			else
			{
				throw new Error("Couldn't find " + className);
			}
		}
		
		public function addAllViewsToContextMenu(target:InteractiveObject):void
		{
			var items:Array = [];
			
			getChildren().forEach
			(
				function (element:UIComponent, index:int, array:Array):void
				{
					var item:ContextMenuItem = new ContextMenuItem(element.className);
					
					if (index === 0)
						item.separatorBefore = true;
					
					item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, itemSelectHandler);
						
					items.push(item);
				}
			);
			
			var menu:ContextMenu = target.contextMenu as ContextMenu;
			menu.hideBuiltInItems();
			menu.customItems = items.concat(menu.customItems);
			target.contextMenu = menu;
		}
		
		private function itemSelectHandler(event:ContextMenuEvent):void
		{
			var page:String = ContextMenuItem(event.target).caption;
			
			new ChangeStateThread().startWithData({ page: page });
		}
		
	}
}