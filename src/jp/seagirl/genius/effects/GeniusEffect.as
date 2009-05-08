package jp.seagirl.genius.effects
{
	import mx.core.UIComponent;
	import mx.effects.Effect;
	
	public class GeniusEffect
	{
		public function GeniusEffect(target:UIComponent, factory:Class, params:Object = null)
		{
			_target = target;
			_factory = factory;
			_params = params;
		}
		
		private var _effect:Effect;
		
		public function get effect():Effect
		{
			return _effect;
		}
		
		private var _target:UIComponent;
		
		public function get target():UIComponent
		{
			return _target;
		}
		
		private var _factory:Class;
		
		public function get factory():Class
		{
			return _factory;
		}
		
		private var _params:Object;
		
		public function get params():Object
		{
			return _params;
		}
		
		public function create():Effect
		{
			_effect = new factory(target);
			
			for (var key:Object in params)
			{
				if (_effect.hasOwnProperty(key))
					_effect[key] = params[key];
			}
			
			return _effect;
		}
	}
}