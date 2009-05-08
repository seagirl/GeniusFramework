package jp.seagirl.genius.effects
{
	import mx.effects.CompositeEffect;
	import mx.effects.Effect;
	
	public class GeniusCompositeEffect implements IGeniusEffect
	{
		public function GeniusCompositeEffect()
		{
			
		}
		
		protected var root:CompositeEffect;
		
		protected var effects:Array = [];
		
		public function create():Effect
		{
			var l:int = effects.length;
			
			for (var i:int = 0; i < l; i++)
			{
				root.addChild(effects[i].create());
			}
			
			return root;	
		}

	}
}