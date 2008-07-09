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
		
		[Bindable]
		/**
		 * データを読み込み終わったかどうかを表します。
		 */	
		public var loaded:Boolean = false;
		
		//----------------------------------
		//  isLoading
		//----------------------------------
		
		/**
		 * データの読み込み処理をしているかどうかを表します。
		 */	
		public var isLoading:Boolean = false;
		
		//----------------------------------
		//  lastModified
		//----------------------------------
		
		/**
		 * 最後にデータを読み込んだ時間、または最後に同期した時間です。
		 */	
		public var lastModified:String;
		
		//----------------------------------
		//  lastResult
		//----------------------------------
		
		[Bindable]
		/**
		 * サービスとの通信結果です。
		 */		
		public var lastResult:XML;
		
		//----------------------------------
		//  currentId
		//----------------------------------
		
		[Bindable]
		/**
		 * 選択されているidです。
		 */
		public var currentId:XML;
		
		//----------------------------------
		//  currentItem
		//----------------------------------
		
		[Bindable]
		/**
		 * 選択されているアイテムです。
		 */
		public var currentItem:XML;
		
		//----------------------------------
		//  rawdata
		//----------------------------------
		
		[Bindable]
		/**
		 * 読み込まれたデータです。
		 */
		public var rawdata:XMLList;
		
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
			if (loaded == false && isLoading == false)
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
		 * データからアイテムを取り出します。
		 * @param value 値
		 * @param key キー
		 * @param ns XML名前空間
		 * @return 
		 */		
		public function getItem(value:String, key:String = 'id', ns:Namespace = null):XML
		{
			if (rawdata == null)
				throw new Error("no data.");
			
			if (ns == null)
				ns = new Namespace();
			
			var ret:XML = null;	
			
			var length:int = rawdata.length();
			for (var i:int; i < length; i++)
			{
				if (rawdata[i].ns::[key].toString() == value)
					ret = currentItem = rawdata[i];
			}
			
			if (ret == null)
				throw new Error("Can't find a data.");
				
			return ret;
		}
		
		/**
		 * 既存のデータを新しいデータで上書きする形でマージします。
		 * 
		 * @param value 新しいデータ
		 * @param key マージに使われるキー
		 * @param ns XML名前空間
		 */			
		public function merge(value:XMLList, key:String = 'id', ns:Namespace = null):void
		{
			if (rawdata == null)
			{
				rawdata = value;
				return;
			}
			
			if (ns == null)
				ns = new Namespace();

			var data1Length:int = rawdata.length();
			var data2Length:int = value.length();
			
			var data1Index:int = data1Length;
				
			for (var i:int = 0; i < data2Length; i++)
			{
				if (value[i].ns::[key] == undefined)
				{
					throw new Error('新しいデータのノードに子ノード「' + key + '」が見つかりません。');
				}
				
				var changedIndex:int = -1;
				
				for (var j:int = 0; j < data1Length; j++) 
				{
					if (rawdata[j].ns::[key] == undefined)
						throw new Error('既存のデータのノードに子ノード「' + key + '」が見つかりません。');
					
					if (rawdata[j].ns::[key] == value[i].ns::[key])
						changedIndex = j;
				}
				
				if (changedIndex > -1)
					rawdata[changedIndex] = value[i];
				else
					rawdata[data1Index++] = value[i];
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