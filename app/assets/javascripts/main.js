window.main = {
    toggleFullWindow: function(selector) {
		finalSelector = '#modal-full-window' + selector;

    	$(finalSelector).toggle();
    	if ($(finalSelector).is(':visible')) {
    		$("body").css("overflow", "hidden");
    	} else {
    		$("body").css("overflow", "auto");
    	}
        window.main.convertDatePickers('.datepicker');
    },
    convertDatePickers: function(selector) {
        jQuery(selector).datetimepicker({
            timepicker: (selector != '.datepicker'),
            format: (selector != '.datepicker') ? 'Y-m-d H:i:s' : 'Y-m-d'
        });
    },
    presentErrors: function(errors, formSelector, fieldsPrefix) {
        var form = $(formSelector);
        for (var i in errors) {
            var name = (fieldsPrefix == '') ? i : fieldsPrefix + "[" + i + "]";
            var _ferr = [];
            for (var k in errors[i]) {
                err = errors[i][k].split(':');
                err = (err.length > 1) ? err[1] : err[0];
                _ferr.push(err);
            }
            form.find('input[name="' + name + '"]').after('<label class="error">' + _ferr.join(',') + '</label>');
            form.find('input[name="' + name + '"]').parents('.form-group').addClass("has-error");
        }
    },
    parseHttpErrors: function(formSelector, errors) {
        $.each($(formSelector).find("p.error"), function(counter, el){
            console.log(el);
            $(el).html("");
        });

        for (var i in errors) {
            $(formSelector).find("p.error." + i.toString() + "-error").html(errors[i].join(","));
        }
    },
    sendForm: function(btn, selector, url) {
        $(btn).attr("disabled", "disabled");
    	$.post(url, $(selector).serialize(), function() {
            $(btn).attr("disabled", false);
            Turbolinks.visit(location.toString());
    	})
    	.fail(function(data, status) {
            $(btn).attr("disabled", false);
    		if (data.status == 400 && data.responseJSON != undefined) {
                window.main.parseHttpErrors(selector, data.responseJSON.errors);
            }
    	});
    }
};