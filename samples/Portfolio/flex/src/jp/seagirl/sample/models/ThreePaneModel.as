package jp.seagirl.sample.models
{
	import jp.seagirl.genius.models.Model;

	public class ThreePaneModel extends Model
	{	
		private static var _instance:ThreePaneModel;
		
		public static function get instance():ThreePaneModel
		{
			if (_instance == null)
				_instance = new ThreePaneModel();
			return _instance;
		}
		
		public function ThreePaneModel()
		{
			if (_instance != null)
				throw new Error("Public construction not allowed.");
		}
		
	}
}