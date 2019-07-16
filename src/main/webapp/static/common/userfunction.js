$.extend($.fn.datagrid.defaults.editors, {
		combogrid : {
			init : function(container, options) {
				var input = $(
						'<inputtype="text" class="datagrid-editable-input">')
						.appendTo(container);
				input.combogrid(options);
				return input;
			},
			destroy : function(target) {
				$(target).combogrid('destroy');
			},
			getValue : function(target) {
				return $(target).combogrid('getValue');
			},
			setValue : function(target, value) {
				$(target).combogrid('setValue', value);
			},
			resize : function(target, width) {
				$(target).combogrid('resize', width);
			},
		},
	    datebox: {
	        init: function (container, options) {
	            var input = $('<input type="text">').appendTo(container);
	            input.datebox(options);
	            return input;
	        },
	        destroy: function (target) {
	            $(target).datebox('destroy');
	        },
	        getValue: function (target) {
	            return $(target).datebox('getValue');//获得旧值
	        },
	        setValue: function (target, value) {
	            $(target).datebox('setValue', value);//设置新值的日期格式
	        },
	        resize: function (target, width) {
	            $(target).datebox('resize', width);
	        }
	    },
	    textReadonly: {
	        init: function (container, options) {
	            var input = $('<input type="text" readonly="readonly" style="height:31px" class="datagrid-editable-input">').appendTo(container);
	            return input;
	        },
	        getValue: function (target) {
	            return $(target).val();
	        },
	        setValue: function (target, value) {
	            $(target).val(value);
	        },
	        resize: function (target, width) {
	            var input = $(target);
	            if ($.boxModel == true) {
	                input.width(width - (input.outerWidth() - input.width()));
	            } else {
	                input.width(width);
	            }
	        }
	    }
	    
	}); 