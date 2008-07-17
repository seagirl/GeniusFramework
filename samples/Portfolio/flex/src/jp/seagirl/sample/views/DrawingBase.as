package jp.seagirl.sample.views
{
	import flash.events.MouseEvent;
	import flash.media.Video;
	
	import jp.seagirl.genius.views.ViewBase;
	
	import mx.controls.Button;
	import mx.controls.ColorPicker;
	import mx.controls.NumericStepper;
	import mx.events.ColorPickerEvent;
	import mx.events.FlexEvent;
	import mx.events.NumericStepperEvent;

	public class DrawingBase extends ViewBase
	{		
		private var lineStyle:Object;
		
		public var clearButton:Button;
		public var numericStepper:NumericStepper;
		public var colorPicker:ColorPicker;
		
		override protected function initializeView():void
		{
			initLineStyle();
			setLineStyle();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			clearButton.addEventListener(MouseEvent.CLICK, clearBtnClickHandler);
			numericStepper.addEventListener(NumericStepperEvent.CHANGE, numericStepperChangeHandler);
			colorPicker.addEventListener(ColorPickerEvent.CHANGE, colorPickerChangeHandler);
		}
		
		public function initLineStyle():void
		{
			lineStyle =
			{
				thickness: 1,
				color: 0x000000,
				alpha: 1
			};
		}
		
		public function setLineStyle():void
		{
			graphics.lineStyle(lineStyle.thickness, lineStyle.color, lineStyle.alpha);
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			graphics.moveTo(mouseX, mouseY);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function mouseMoveHandler(event:MouseEvent):void
		{
			graphics.lineTo(mouseX, mouseY);
		}
		
		private function mouseUpHandler(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}
		
		private function clearBtnClickHandler(event:MouseEvent):void
		{
			graphics.clear();
			setLineStyle();
		}
		
		private function numericStepperChangeHandler(event:NumericStepperEvent):void
		{
			lineStyle.thickness = event.target.value;
			setLineStyle();
		}
		
		private function colorPickerChangeHandler(event:ColorPickerEvent):void
		{
			lineStyle.color = event.target.selectedColor;
			setLineStyle();
		}
		
	}
}