class InvoiceSettings {
	dynamic customFields;
	dynamic defaultPaymentMethod;
	dynamic footer;
	dynamic renderingOptions;

	InvoiceSettings({
		this.customFields, 
		this.defaultPaymentMethod, 
		this.footer, 
		this.renderingOptions, 
	});

	factory InvoiceSettings.fromJson(Map<String, dynamic> json) {
		return InvoiceSettings(
			customFields: json['custom_fields'],
			defaultPaymentMethod: json['default_payment_method'],
			footer: json['footer'],
			renderingOptions: json['rendering_options'],
		);
	}



	Map<String, dynamic> toJson() => {
				if (customFields != null) 'custom_fields': customFields,
				if (defaultPaymentMethod != null) 'default_payment_method': defaultPaymentMethod,
				if (footer != null) 'footer': footer,
				if (renderingOptions != null) 'rendering_options': renderingOptions,
			};
}
