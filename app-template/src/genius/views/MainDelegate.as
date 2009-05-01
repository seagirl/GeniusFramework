package [% package %].views
{
	import jp.seagirl.genius.controllers.ViewDelegate;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.UIComponent;
	
	import [% package %].threads.ChangeStateThread;

	public class MainDelegate extends ViewDelegate
	{
		// View
		public var view:Main;
		
		override protected function initialize():void
		{
			BindingUtils.bindSetter(changePage, context, 'state');
		}
		
		private function changePage(data:Object):void
		{
			if (data == null)
				return;
				
			var child:UIComponent;
			
			view.viewStack.getChildren().forEach
			(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == context.state.page)
						child = element;
				}
			);
			
			if (child)
			{
				var oldIndex:int = view.viewStack.selectedIndex;
				var newIndex:int = view.viewStack.getChildIndex(child);
				
				view.viewStack.selectedIndex = newIndex;
				
				return;
			}
			
			new ChangeStateThread().start();
		}
		
	}
}