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

package jp.seagirl.genius.views
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import mx.containers.Canvas;
	import mx.containers.ViewStack;
	import mx.controls.ComboBox;
	import mx.controls.DateField;
	import mx.controls.NumericStepper;
	import mx.controls.RadioButton;
	import mx.controls.RadioButtonGroup;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	use namespace mx_internal;

	/**
	 * ViewBaseはビューに関するロジックを記述するためのクラスのための
	 * ベースとなるクラスです。
	 * 
	 * @author yoshizu
	 */
	public class ViewBase extends Canvas
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 */
		public function ViewBase()
		{
			super();
			addEventListener(FlexEvent.ADD, addHandler);
			addEventListener(FlexEvent.REMOVE, removeHandler);
			addEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
			addEventListener(FlexEvent.INITIALIZE, initializeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  active
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _active:Boolean = true;
		
		/**
		 * ビューがアクティブかどうかを示します。
		 * ビューがViewStackの子供の場合、
		 * 非選択状態になるとfalseになります。
		 * falseからtrueに変わる時にのみupdateView()が呼ばれます。
		 * 
		 * @return  
		 */		
		public function get active():Boolean
		{
			return _active;
		}
		
		/**
		 * @private 
		 */		
		public function set active(value:Boolean):void
		{
			if (_active != value)
			{
				_active = value;
				
				if (initialized && _active)
					updateView();
			}	
		}
		
		//----------------------------------
		//  validators
		//----------------------------------

		/**
		 * バリデータオブジェクトのためのストレージ
		 * 
		 * @return  
		 */
		public var validators:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * ビューに含まれる全てのUIComponentのenabledを一度に変更します。
		 * 
		 * @param value 
		 */		
		public function enabledAll(value:Boolean = true):void
		{
			enabledChildren(this);
			
			function enabledChildren(container:DisplayObjectContainer):void
			{
				var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++)
				{
					child = container.getChildAt(i);
					if (child is UIComponent)
						UIComponent(child).enabled = value;
					if (child is DisplayObjectContainer)
						enabledChildren(DisplayObjectContainer(child));
				}
			}
		}
		
		/**
		 * フォームアイテムをリセットします。 
		 */		
		public function resetFormItems():void
		{
			resetValues(this);
			validateNow();
			resetErrorStrings(this);
			
			function resetValues(container:DisplayObjectContainer):void
			{
				var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++)
				{
					child = container.getChildAt(i);
					if (child is TextInput)
						TextInput(child).text = '';
					else if (child is TextArea)
						TextArea(child).text = '';
					else if (child is NumericStepper)
						NumericStepper(child).value = 0;
					else if (child is DateField)
						DateField(child).selectedDate = null;
					else if (child is RadioButtonGroup)
						RadioButtonGroup(child).selection = null;
					else if (child is ComboBox)
						ComboBox(child).selectedIndex = ComboBox(child).prompt == null ? 0 : -1;
					else if (child is DisplayObjectContainer)
						resetValues(DisplayObjectContainer(child));
				}
			}
			
			function resetErrorStrings(container:DisplayObjectContainer):void
			{
				var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++)
				{
					child = container.getChildAt(i);
					if (child is TextInput)
						TextInput(child).errorString = '';
					else if (child is TextArea)
						TextArea(child).errorString = '';
					else if (child is NumericStepper)
						NumericStepper(child).errorString = '';
					else if (child is DateField)
						DateField(child).errorString = '';
					else if (child is RadioButton)
						RadioButton(child).errorString = '';
					else if (child is ComboBox)
						ComboBox(child).errorString = '';
					else if (child is DisplayObjectContainer)
						resetErrorStrings(DisplayObjectContainer(child));
				}
			}
		}
		
		/**
		 * 初期化処理の最後に呼び出されます。
		 * このメソッドをオーバーライドして、実装して下さい。
		 */		
		protected function initializeView():void
		{
			
		}
		
		/**
		 * ビューを更新します。
		 * ビューがViewStackの子供の場合、
		 * 選択されるとこのメソッドが呼ばれます。 
		 */		
		protected function updateView():void
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * FlexEvent.PREINITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function preinitializeHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.PREINITIALIZE, preinitializeHandler);
		}
		
		/**
		 * FlexEvent.INITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function initializeHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.INITIALIZE, initializeHandler);
			initializeView();
			updateView();
		}
		 
		/**
		 * FlexEvent.CREATION_COMPLETEで呼ばれるハンドラ
		 * @param event 
		 */		 
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
		}
		
		
		/**
		 * @private
		 */			
		private function addHandler(event:FlexEvent):void
		{
			if (parent is ViewStack)
				parent.addEventListener(Event.CHANGE, parentChangeHandler);
		}
		
		/**
		 * @private
		 */		
		private function removeHandler(event:FlexEvent):void
		{
			if (parent.hasEventListener(Event.CHANGE))
				parent.removeEventListener(Event.CHANGE, parentChangeHandler);
		}
	
		/**
		 * @private
		 */			
		private function parentChangeHandler(event:Event):void
		{
			active = (ViewStack(parent).selectedChild == this) ? true : false;
		}
	}
}