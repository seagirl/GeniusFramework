package jp.seagirl.sample.views
{
	import flash.events.Event;
	
	import jp.seagirl.collections.SortCompareFunction;
	import jp.seagirl.genius.views.ViewBase;
	import jp.seagirl.sample.models.ThreePaneModel;
	import jp.seagirl.sample.threads.threePane.LoadThreePaneThread;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.controls.Text;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.events.PropertyChangeEvent;
	import mx.formatters.DateFormatter;
	import mx.managers.CursorManager;

	public class ThreePaneBase extends ViewBase
	{		
		private var sortCondition:Sort;
		
		public var dataGrid:DataGrid;
		public var idDataGridColumn:DataGridColumn;
		public var titleDataGridColumn:DataGridColumn;
		public var createdDataGridColumn:DataGridColumn;
		public var modifiedDataGridColumn:DataGridColumn;
		public var text:Text;
		
		override protected function initializeView():void
		{
			titleDataGridColumn.sortCompareFunction = SortCompareFunction.byString('title');
			createdDataGridColumn.sortCompareFunction = SortCompareFunction.byString('created');
			modifiedDataGridColumn.sortCompareFunction = SortCompareFunction.byString('modified');
			
			createdDataGridColumn.labelFunction = dataGridColumnLabelFunction;
			modifiedDataGridColumn.labelFunction = dataGridColumnLabelFunction;
			
			ChangeWatcher.watch(ThreePaneModel.instance, 'data', threePaneDataPropertyChangeHandler);
			ChangeWatcher.watch(ThreePaneModel.instance, 'lastResult', threePaneLastResultPropertyChangeHandler);
			
			dataGrid.addEventListener(Event.CHANGE, dataGridClickHandler);
		}
		
		override protected function updateView():void
		{
			CursorManager.setBusyCursor();
			new LoadThreePaneThread().start();
		}
		
		private function dateToString(date:String):String
		{
			var splittedByDotStrings:Array = date.split('.');
			var dateFormattedString:String = String(splittedByDotStrings[0]).replace(/-/g, '/');
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = 'YYYY年M月D日 J時N分';
			return dateFormatter.format(dateFormattedString);
		}
		
		private function dataGridColumnLabelFunction(data:Object, self:DataGridColumn):String
		{
			return dateToString(data[self.dataField]);
		}
		
		private function threePaneDataPropertyChangeHandler(event:PropertyChangeEvent):void
		{
			if (!active) return;
			
			var data:XMLList = XMLList(event.newValue);
			var collection:XMLListCollection = new XMLListCollection(data);
			
			if (sortCondition == null)
			{
				sortCondition = new Sort();
				sortCondition.fields = [new SortField('id', true, true, true)];
			}
			
			collection.sort = sortCondition;
			collection.refresh();
			
			dataGrid.dataProvider = collection;
			
			CursorManager.removeAllCursors();	
		}
		
		private function threePaneLastResultPropertyChangeHandler(event:PropertyChangeEvent):void
		{
			if (!active) return;

			var data:XML = XML(event.newValue)
			if (data.status.toString() == -1)
				Alert.show('サーバーとの通信に失敗しました。', 'エラー');
		}
		
		private function dataGridClickHandler(event:Event):void
		{
			var data:XML = dataGrid.selectedItem as XML;
			if (data)
				text.text = data.content;
		}

		
	}
}