package jp.seagirl.sample.models
{
	import jp.seagirl.genius.models.Model;

	public class AmazonModel extends Model
	{			
		private static var _instance:AmazonModel;
		
		public static function get instance():AmazonModel
		{
			if (_instance == null)
				_instance = new AmazonModel();
			return _instance;
		}
		
		public function AmazonModel()
		{
			if (_instance != null)
				throw new Error("Public construction not allowed.");
		}
		
	}
}