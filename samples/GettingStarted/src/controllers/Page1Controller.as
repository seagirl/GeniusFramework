package controllers
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.effects.GeniusEffect;
	import jp.seagirl.genius.effects.GeniusParallel;
	import jp.seagirl.genius.effects.GeniusSerial;
	import jp.seagirl.genius.threads.ChangeStateThread;
	
	import mx.effects.Dissolve;
	import mx.effects.Move;
	import mx.effects.easing.Quadratic;
	
	import views.Page1;

	public class Page1Controller extends ViewController
	{	
		public function Page1Controller(view:Object)
		{
			super(view);
		}
		
		public var view:Page1;
		
		override protected function initialize():void
		{
			trace('initialize page1.');
			
			showEffects = new GeniusParallel(
				new GeniusEffect(
					view,
					Dissolve,
					{
						duration: 1200
					}
				),
				new GeniusSerial(
					new GeniusEffect(
						view,
						Move,
						{
							xFrom: 0,
							xTo: 50,
							duration: 300
						}
					),
					new GeniusEffect(
						view,
						Move,
						{
							xTo: 0,
							duration: 300,
							easingFunction: Quadratic.easeOut
						}
					)
				)
			);
			
			hideEffects = new GeniusEffect(view, Dissolve);
		}
		
		override public function update():void
		{
			trace('update page1.');
		}
		
	}
}