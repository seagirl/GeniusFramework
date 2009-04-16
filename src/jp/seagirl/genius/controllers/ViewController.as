package jp.seagirl.genius.controllers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import jp.seagirl.controls.Notifier;
	
	import mx.controls.ComboBox;
	import mx.controls.DateField;
	import mx.controls.NumericStepper;
	import mx.controls.RadioButton;
	import mx.controls.RadioButtonGroup;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.validators.Validator;
	
	public class ViewController extends Controller
	{		
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
		
		override public function initialized(document:Object, id:String):void
		{
			super.initialized(document, id);
			
			var delegate:ApplicationDelegate;
			
			if (Application.application.data.hasOwnProperty('delegate'))
				delegate = Application.application.data.delegate;

			if (Application.application.hasOwnProperty('delegate'))
				delegate = Application.application.delegate;
				
			if (delegate == null)
				throw new Error("Couldn't find any ApplicationDelegate.");
				
			context = delegate.context;
		}
		
		override protected function view_initializeHandler(event:FlexEvent):void
		{
			super.view_initializeHandler(event);
			
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