package br.com.raphamaster.utils
{
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.NumberFormatter;
	
	public class FormataValores
	{
		public function strToFloat(valor:String, precisao:int = -1):Number
		{
			var nf:NumberFormatter = new NumberFormatter();
			nf.decimalSeparatorFrom = ",";
			nf.decimalSeparatorTo = ".";
			nf.thousandsSeparatorFrom = ".";
			nf.thousandsSeparatorTo = ","
			nf.useThousandsSeparator = false;
			nf.precision = precisao;
			
			return Number(nf.format(valor));
		}
		
		public function floatToStr(valor:String, precisao:int = 2):String
		{
			var nf:CurrencyFormatter = new CurrencyFormatter();
			nf.decimalSeparatorTo = ",";
			nf.thousandsSeparatorTo = ".";
			nf.useThousandsSeparator = true;
			nf.currencySymbol = "R$ ";
			nf.precision = precisao;
			
			return nf.format(valor);
		}

	}
}