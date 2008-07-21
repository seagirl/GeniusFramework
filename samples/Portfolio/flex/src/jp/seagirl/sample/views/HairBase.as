package jp.seagirl.sample.views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.views.ViewBase;
	
	import mx.controls.Button;
	import mx.events.FlexEvent;

	public class HairBase extends ViewBase
	{
		private var numPoints:uint = 2;
		
		public var button:Button;
		
		override protected function initializeView():void
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
		}
		
		override protected function updateView():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			numPoints = 2;
			button.label = 'Start';
		}
		
		private function render():void
		{
			var points:Array = [];
			for (var i:int = 0; i < numPoints; i++) {
				points[i] = {};
				points[i].x = Math.random() * width;
				points[i].y = Math.random() * height;
			}
			
			graphics.lineStyle(1);
			graphics.moveTo(points[0].x, points[0].y);
			
			for (var j:int = 1; j < numPoints - 2; j++) {
				var xc:Number = (points[j].x + points[j+1].x) / 2;
				var yc:Number = (points[j].y + points[j+1].y) / 2;
				graphics.curveTo(points[j].x, points[j].y, xc, yc);
			}
			graphics.curveTo(points[j].x, points[j].y, points[j+1].x, points[j+1].y);
		}
		
		private function enterFrameHandler(event:Event):void
		{
			if (!active)
				return;
			
			numPoints++;
			graphics.clear();
			render();
		}
		
		private function buttonClickHandler(event:MouseEvent):void
		{
			if (hasEventListener(Event.ENTER_FRAME))
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				numPoints = 2;
				button.label = 'Start';
			}
			else
			{
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
				button.label = 'Stop';
			}
		}
		
	}
}