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
 
 package jp.seagirl.genius.controllers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import jp.seagirl.controls.Notifier;
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.effects.IGeniusEffect;
	import jp.seagirl.genius.models.Model;
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	import mx.controls.ComboBox;
	import mx.controls.DateField;
	import mx.controls.NumericStepper;
	import mx.controls.RadioButton;
	import mx.controls.RadioButtonGroup;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.events.FlexEvent;
	import mx.validators.Validator;
	
	public class ViewController
	{
		public function ViewController(view:Object)
		{
			initWithView(view);
		}
		
		//----------------------------------
		//  showEffect
		//----------------------------------
		
		private var _showEffects:IGeniusEffect;
		private var _flexShowEffects:Effect;
		
		public function get showEffects():IGeniusEffect
		{
			return _showEffects;
		}
		
		public function set showEffects(value:IGeniusEffect):void
		{
			_showEffects = value;
			_flexShowEffects = _showEffects.create();
			
			this['view'].setStyle('showEffect', _flexShowEffects);
			this['view'].setStyle('creationCompleteEffect', _flexShowEffects);
		}
		
		//----------------------------------
		//  hideEffect
		//----------------------------------
		
		private var _hideEffects:IGeniusEffect;
		private var _flexHideEffects:Effect;
		
		public function get hideEffects():IGeniusEffect
		{
			return _hideEffects;
		}
		
		public function set hideEffects(value:IGeniusEffect):void
		{
			_hideEffects = value;
			_flexHideEffects = _hideEffects.create();
			
			this['view'].setStyle('hideEffect', _flexHideEffects);
		}
		
		//----------------------------------
		//  name
		//----------------------------------
		
		public var name:String;
		
		//----------------------------------
		//  context
		//----------------------------------
		
		public var context:Context;
		
		//----------------------------------
		//  viewClass
		//----------------------------------
		
		public var viewClass:Class;
		
		//----------------------------------
		//  active
		//----------------------------------
		
		/**
		 * ビューがアクティブかどうかを示します。
		 * 
		 * @return  
		 */		
		public var active:Boolean = false;
		
		//----------------------------------
		//  notifier
		//----------------------------------
		
		/**
		 * メッセージを通知するビュー
		 * @return  
		 */	
		public var notifier:Notifier = new Notifier();
		
		//----------------------------------
		//  vars
		//----------------------------------
		
		/**
		 * ビューと共用する汎用データオブジェクト
		 * 
		 * @return  
		 */
		[Bindable]
		public var vars:ObjectProxy = new ObjectProxy();
		
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
		
		protected function getModel(modelName:String):Model
		{
			return context.getModel(modelName);
		}
		
		protected function getViewClass():Class
		{
			var className:String = getQualifiedClassName(this['view']);				
			var viewClassName:String = className.replace(/::/g, '.');
			var viewClass:Class;
			
			try
			{
				viewClass = getDefinitionByName(viewClassName) as Class
			}
			catch(e:Error)
			{
				viewClass = null;
			}
			
			return viewClass;
			
		}
		
		protected function initWithView(view:Object):void
		{
			var flagments:Array = getQualifiedClassName(this).split("::");
			name = flagments[flagments.length - 1];
			
			context = ApplicationDelegate.sharedApplicationDelegate().context;
			
			if (!hasOwnProperty('view'))
				throw new Error("対応する View が見つかりません。");
			
			this['view'] = view;
			
			viewClass = getViewClass();

			this['view'].addEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			this['view'].addEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
		}
		
		/**
		 * ビューに含まれる全てのUIComponentのenabledを一度に変更します。
		 * 
		 * @param value 
		 */		
		public function enabledAll(value:Boolean = true):void
		{
			
			if (!hasOwnProperty('view') || !viewClass)
				throw new Error("対応する View が見つかりません。");
				
			enabledChildren(this['view']);
			
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
			if (!hasOwnProperty('view') || !viewClass)
				throw new Error("対応する View が見つかりません。");
				
			resetValues(this['view']);
			this['view'].validateNow();
			resetErrorStrings(this['view']);
			
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
		 * validators に入っている全てのバリデータを使って検証します。 
		 */		
		public function validate():Boolean
		{
		    return Validator.validateAll(validators).length ? false : true;
		}
		
		protected function initialize():void
		{
			
		}
		
		protected function creationComplete():void
		{
			
		}
		
		public function update():void
		{
			
		}
		
		/**
		 * FlexEvent.INITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function view_initializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			
			initialize();
			
			this['view'].addEventListener(FlexEvent.SHOW, view_showHandler);
			this['view'].addEventListener(FlexEvent.HIDE, view_hideHandler);
			
			notifier.create();
			
			if (context.state.page == this['view'].className)
			{
				active = true;
				update();
			}
		}
		 
		/**
		 * FlexEvent.CREATION_COMPLETEで呼ばれるハンドラ
		 * @param event 
		 */		 
		protected function view_creationCompleteHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
			
			creationComplete();
		}
		
		/**
		 * @private
		 */			
		protected function view_showHandler(event:FlexEvent):void
		{
			if (active)
				return;
			
			active = true;
			
			update();
		}
		
		/**
		 * @private
		 */			
		protected function view_hideHandler(event:FlexEvent):void
		{
			active = false;
		}

	}
}