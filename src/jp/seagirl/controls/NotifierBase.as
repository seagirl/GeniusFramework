package jp.seagirl.controls
{
	import flash.utils.setTimeout;
	
	import mx.containers.Canvas;
	import mx.core.Application;
	import mx.core.UIComponent;

	public class NotifierBase extends Canvas
	{		
		[Bindable]
		public var text:String;
		
		public function create(target:UIComponent = null):void
		{
			if (target == null)
				target = Application.application as UIComponent;
			
			target.addChild(this);
			setStyle('bottom', 10);
			setStyle('right', 10);
			visible = false;
		}
		
		public function show(text:String = null):void
		{	
			if (text != null)
				this.text = text;
			
			visible = true;
			setTimeout(
				function ():void
				{
					visible = false;	
				},
				3000
			);
		}
		
	}
}
