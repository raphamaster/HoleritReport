package br.com.raphamaster.utils
{
	public class Layouts
	{
		import mx.core.UIComponent;
		
		public static function centralizarTela(componente:UIComponent):void 
		{
    		if (componente != null) {
        		var diferencaLargura:Number = componente.screen.width - componente.width;
		        var diferencaAltura:Number = componente.screen.height - componente.height;
        		
				componente.x = componente.screen.x + (diferencaLargura / 2);
		        componente.y = componente.screen.y + (diferencaAltura / 2);
   	 		}
		}

	}
}