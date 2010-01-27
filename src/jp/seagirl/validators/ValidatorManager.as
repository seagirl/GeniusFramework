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

package jp.seagirl.validators
{
	import mx.validators.EmailValidator;
	import mx.validators.NumberValidator;
	import mx.validators.RegExpValidator;
	import mx.validators.StringValidator;
	import mx.validators.Validator;
	
	/**
	 * 複数のValidatorを管理するクラスです。
	 * 
	 * @author yoshizu
	 */	
	public class ValidatorManager
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/** 
		 * コンストラクタ
		 */		
		public function ValidatorManager()
		{
			repository = new Array();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Validatorを格納しておくリポジトリです。
		 */		
		private var repository:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * Validatorを追加します。
		 * 
		 * @param source
		 * @param property
		 * @return 
		 */		
		public function addValidator(source:Object, property:String):Validator
		{
			var validator:Validator = new Validator();
			repository.push(validator);
			validator.source = source;
			validator.property = property;
			return validator;
		}
		
		/**
		 * EmailValidatorを追加します。
		 * 
		 * @param source
		 * @param property
		 * @return 
		 */		
		public function addEmailValidator(source:Object, property:String):Validator
		{
			var validator:EmailValidator = new EmailValidator();
			repository.push(validator);
			validator.source = source;
			validator.property = property;
			return validator;
		}
		
		/**
		 * NumberValidatorを追加します。
		 * 
		 * @param source
		 * @param property
		 * @param minValue
		 * @param maxValue
		 * @return  
		 */		
		public function addNumberValidator(source:Object, property:String, minValue:Number, maxValue:Number):Validator
		{
			var validator:NumberValidator = new NumberValidator();
			repository.push(validator);
			validator.source = source;
			validator.property = property;
			validator.minValue = minValue;
			validator.maxValue = maxValue;
			return validator;
		}
		
		/** 
		 * StringValidatorを追加します。
		 * 
		 * @param source
		 * @param property
		 * @param minLength
		 * @param maxLength
		 * @return 
		 */		
		public function addStringValidator(source:Object, property:String, minLength:Number, maxLength:Number):Validator
		{
			var validator:StringValidator = new StringValidator();
			repository.push(validator);
			validator.source = source;
			validator.property = property;
			validator.minLength = minLength;
			validator.maxLength = maxLength;
			return validator;
		}
		
		/**
		 * RegExpValidatorを追加します。
		 * 
		 * @param source
		 * @param property
		 * @param expression
		 * @return 
		 */		
		public function addRegExpValidator(source:Object, property:String, expression:String = null):Validator
		{
			var validator:RegExpValidator = new RegExpValidator();
			repository.push(validator);
			validator.source = source;
			validator.property = property;
			validator.expression = expression;
			return validator;
		}
		
		public function removeValidator(validator:Validator):void
		{
			repository.filter(
				function (element:Validator, index:int, array:Array):Boolean
				{
					return element != validator;
				}
			);
			
			return;
		}
		
		public function removeAllValidators():void
		{
			repository = [];
			
			return;
		}
		
		/**
		 * リポジトリに登録された全てのValidatorを使って妥当性を判断します。
		 * 
		 * @return 妥当かどうかを返します。 
		 */		
		public function isValid():Boolean
		{
			var valid:Boolean = true;
			for (var index:String in repository) {
				var results:Array = Validator(repository[index]).validate().results;
				if (results != null && results.shift().isError)
					valid = false;
			}
			return valid;
		}
	
	}
}