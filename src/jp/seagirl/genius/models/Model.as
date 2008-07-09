/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 seagirl
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

package jp.seagirl.genius.models
{
	import mx.collections.XMLListCollection;
	import mx.utils.ObjectUtil;
	
	/**
	 * Modelは汎用的なモデルの実装クラスです。
	 * 
	 * @author yoshizu 
	 */	
	public class Model implements IModel
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ 
		 */		
		public function Model()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * デフォルトのフィルタ条件です。 
		 */		
		protected var defaultFilterCondition:Object;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  loaded
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _loaded:Boolean = false;
		
		[Bindable]
		/**
		 * データを読み込み終わったかどうかを表します。
		 */		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		/**
		 * @private 
		 */	
		public function set loaded(value:Boolean):void
		{
			_loaded = value;
		}
		
		//----------------------------------
		//  isLoading
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _isLoading:Boolean = false;
		
		/**
		 * データの読み込み処理をしているかどうかを表します。
		 */
		public function get isLoading():Boolean
		{
			return _isLoading;
		}
		
		/**
		 * @private 
		 */	
		public function set isLoading(value:Boolean):void
		{
			_isLoading = value;
		}
		
		//----------------------------------
		//  lastModified
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _lastModified:String;
		
		/**
		 * 最後にデータを読み込んだ時間、または最後に同期した時間です。
		 */
		public function get lastModified():String
		{
			return _lastModified;
		}
		
		/**
		 * @private 
		 */	
		public function set lastModified(value:String):void
		{
			_lastModified = value;
		}
		
		//----------------------------------
		//  lastResult
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _lastResult:XML;
		
		[Bindable]
		/**
		 * サービスとの通信結果です。
		 */		
		public function get lastResult():XML
		{
			return _lastResult;
		}
		
		/**
		 * @private 
		 */	
		public function set lastResult(value:XML):void
		{
			_lastResult = value;
		}
		
		//----------------------------------
		//  currentId
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _currentId:XML;
		
		[Bindable]
		/**
		 * 選択されているidです。
		 */
		public function get currentId():XML
		{
			return _currentId;
		}
		
		/**
		 * @private 
		 */	
		public function set currentId(value:XML):void
		{
			_currentId = value;
		}
		
		//----------------------------------
		//  currentItem
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _currentItem:XML;
		
		[Bindable]
		/**
		 * 選択されているアイテムです。
		 */
		public function get currentItem():XML
		{
			return _currentItem;
		}
		
		/**
		 * @private 
		 */	
		public function set currentItem(value:XML):void
		{
			_currentItem = value;
		}
		
		//----------------------------------
		//  rawdata
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _rawdata:XMLList;
		
		[Bindable]
		/**
		 * 読み込まれたデータです。
		 */
		public function get rawdata():XMLList
		{
			return _rawdata;
		}
		
		/**
		 * @private 
		 */	
		public function set rawdata(value:XMLList):void
		{
			_rawdata = value;
		}
		
		//----------------------------------
		//  data
		//----------------------------------
		
		/**
		 * @private 
		 */
		private var _data:XMLList;
		
		[Bindable]
		/**
		 *  表示用のデータです。
		 */
		public function get data():XMLList
		{
			if (_loaded == false && _isLoading == false)
				initializeData();
			return _data;
		}
		
		/**
		 * @private 
		 */	
		public function set data(value:XMLList):void
		{
			_data = value;
		}
		
		//----------------------------------
		//  dataFilter
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _dataFilter:IDataFilter;
		
		/**
		 * データに適用するフィルタです。
		 */
		public function get dataFilter():IDataFilter
		{
			return _dataFilter;
		}
		
		/**
		 * @private 
		 */	
		public function set dataFilter(value:IDataFilter):void
		{
			if (dataFilter != value)
			{
				_dataFilter = value;
				if (rawdata != null)
					data = dataFilter.apply(rawdata);	
			}
		}
		
		//----------------------------------
		//  filterCondition
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _filterCondition:Object;
		
		/**
		 * フィルタ条件です。 
		 */	
		public function get filterCondition():Object
		{
			if (_filterCondition == null)
				resetFilterCondition();
			return _filterCondition;
		}
		
		/**
		 * @private 
		 */	
		public function set filterCondition(value:Object):void
		{
			if (_filterCondition != value)
			{
				_filterCondition = value;
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * データの初期化処理を記述します。
		 * このメソッドは初めてdataが呼ばれた時に呼び出されます。
		 */		
		protected function initializeData():void
		{
			
		}
		
		/**
		 * idを使ってデータからアイテムを取り出します。
		 * 
		 * @param value
		 * @return 
		 */		
		public function getItemById(value:int):XML
		{
			var length:int = rawdata.(id == value).length();
			
			if (length == 0)
				throw new Error("Can't find a data.");
			else if (length == 1)
				currentItem = XML(rawdata.(id == value)).copy();
			else
				throw new Error("Invalid data.");
			
			return _currentItem;
		}
		
		/**
		 * 既存のデータを新しいデータで上書きする形でマージします。
		 * 
		 * @param value 
		 */		
		public function merge(value:XMLList, key:String = 'id'):void
		{
			if (rawdata == null)
			{
				rawdata = value;
				return;
			}
			
			var data1Collection:XMLListCollection = new XMLListCollection(rawdata);
			var data2Collection:XMLListCollection = new XMLListCollection(value);
			
			var data2Array:Array = data2Collection.toArray();
			var data2ArrayLength:int = data2Array.length;
			
			for (var i:int; i < data2ArrayLength; i++)
			{
				var length:int = rawdata.(['key'] == data2Array[i]['key']).length();
					
				if (length == 0)
					data1Collection.addItem(data2Array[i]);
				else if (length == 1)
					rawdata.([key] == data2Array[i][key]).setChildren(data2Array[i].children());
				else
					throw new Error('Invalid data.');
			}
		}
		
		/**
		 * フィルタ条件をデフォルト値にします。
		 */		
		public function resetFilterCondition():void
		{
			_filterCondition = ObjectUtil.copy(defaultFilterCondition);
		}

	}
}