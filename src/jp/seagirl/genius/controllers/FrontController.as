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
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import jp.seagirl.genius.commands.ICommand;
	import jp.seagirl.genius.commands.ISequenceCommand;

	/**
	 * FrontControllerは、イベントに紐付けたコマンドを扱うクラスです。
	 * （互換性のために残してある古いクラスです。）
	 * 
	 * @author yoshizu
	 */
	public class FrontController
	{	
		//--------------------------------------------------------------------------
		//
		//  variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * コマンドを格納するためのオブジェクト
		 */
		protected var commands:Dictionary = new Dictionary();
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コマンドを追加するメソッドです。
		 * 
		 * @param name
		 * @param reference
		 * @param useWeakReference 
		 */		
		public function addCommand(name:String, reference:Class, useWeakReference:Boolean=true):void
		{
			if (commands[name] != null)
				throw new Error('Command "' + name + '" is already registerd');
				
			commands[name] = reference;
			GeniusEventDispatcher.instance
				.addEventListener(name, executeCommand, false, 0, useWeakReference);
		}
		
		/**
		 * コマンドを削除するメソッドです。
		 * 
		 * @param name 
		 */		
		public function removeCommand(name:String):void
		{
			if (commands[name] === null)
				throw new Error('Command "' + name + '" is not registerd');
				
			GeniusEventDispatcher.instance.removeEventListener(name, executeCommand);
			commands[name] = null;
			delete commands[name];
		}
		
		/**
		 * コマンドが存在するかどうかを調べます。
		 * 
		 * @param name
		 * @return 
		 */		
		public function hasCommand(name:String):Boolean
		{
			return commands[name] != null
		}	
			
		/**
		 * コマンドを実行するメソッドです。
		 * 
		 * @param event 
		 */		
		public function executeCommand(event:GeniusEvent):void
		{
			var name:String = event.type;
			var reference:Class = commands[name];
			
			if (reference == null)
				throw new Error('Command "' + name + '" is not found');
			
			var command:ICommand = new reference();
			if (command is ISequenceCommand)
				ISequenceCommand(command).addEventListener(
					Event.COMPLETE, commandCompleteHandler, false, 0, true);
			command.execute(event);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private function commandCompleteHandler(event:Event):void
		{
			var command:ISequenceCommand = ISequenceCommand(event.target);
			command.removeEventListener(Event.COMPLETE, commandCompleteHandler);
			if (command.nextEvent != null)
				GeniusEventDispatcher.instance.dispatchEvent(command.nextEvent);
		}
	}
}