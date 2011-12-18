package br.com.raphamaster.control
{
		import br.com.raphamaster.components.Alertas;
		import br.com.raphamaster.util.ImageUtil;
		
		import flash.display.DisplayObject;
		import flash.events.MouseEvent;
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		
		import mx.core.Application;		
		import mx.events.FlexEvent;
		import mx.managers.PopUpManager;
		
	public class Alerta extends Alertas
	{
		 
    /**
     * Responsavel por exibir e controlar o componente de alerta na tela.
     *     
     */
     
        private var _novaAltura:int;
 
        private var _duracao:int = 3000;
 
        private var _timerOcultarAlerta:Timer;
 
        public static var ALERTA_SUCESSO:int = 0;
        public static var ALERTA_WARNING:int = 1;
        public static var ALERTA_ERRO:int 	 = 2;
 
        public function Alerta() {
            super();
 
            this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreate);
        }
 
        /**
         * @private
         * Espera o alerta ser totalmente criado para seguir o fluxo de configuraçao de posicionamento.
         * @param evt
         */
        private function onCreate(evt:FlexEvent):void {
 
            /* Definindo o local onde o alerta será exibido,
             * Por simplicidade irei adotar o mesmo padrao do MSN, Twitter e outros, ou seja,
             * no canto inferior direito da tela
             *
             * Define o X, para isso pega-se o tamanho total da tela - o tamanho do nosso alerta - um gap qualquer.
             * Define o Y, para isso pega-se a (altura total da tela - um gap qualquer) - (a altura do nosso alerta * total de alerta visiveis na tela)  */
            this.x = Application.application.width - this.width - 5;
            this.y = (Application.application.height - 5) - (this.height * GerenciadorAlerta.getInstance().totalAlertaVisivel);
 
            /* Configurando os efeitos de MOVE. */
            this.mvExibirAlerta.yFrom = Application.application.height;
            this.mvExibirAlerta.yTo = y;
 
            this.mvOcultarAlerta.yTo = Application.application.height;
 
            /* Configurando o eventos do MOUSE
             *
             * Apos o alerta ser exibido o mesmo ficará visivel apenas por um determinado tempo.
             * Desta maneira caso o demore para ler a msg o alerta será ocultado, para que isso nao aconteça
             * iremos definir que quando o usuario colocar o mouse em cima o alerta o mesmo fica disponivel ate
             * que o usuario retire o mouse de cima do alerta. */
            this.addEventListener(MouseEvent.ROLL_OVER, function():void {
                _timerOcultarAlerta.removeEventListener(TimerEvent.TIMER_COMPLETE, fecharAlerta);
            });
 
            this.addEventListener(MouseEvent.ROLL_OUT, function():void {
                fecharAlerta(null);
            });
 
            /* Configurando o Tempo 'Timer' no qual o alerta ficará disponivel antes de ser ocultado */
            _timerOcultarAlerta = new Timer(_duracao, 1);
            _timerOcultarAlerta.addEventListener(TimerEvent.TIMER_COMPLETE, fecharAlerta);
            _timerOcultarAlerta.start();
 
            /* Ao sair deste metodo o efeito Parallel que nos deixamos como Bindable no creationCompleteEffect da Tela
             * será ativado */
        }
 
        /**
         * @private
         * Remove o alerta da Tela.
         * Neste momento o efeito Parallel que nos deixamos como Bindable no removedEffect da Tela
         * será ativado
         * @param evt
         */
        private function fecharAlerta(evt:TimerEvent):void{
            PopUpManager.removePopUp( this );
 
            /* Avisa o gerenciador que foi removido um Alerta */
            GerenciadorAlerta.getInstance().alertaRemovido();
        }
 
        /**
         * Responsavel por criar, configurar e exibir o Alerta tendo como base os argumentos como referencia.
         *
         * @param titulo Define o titulo a ser exibido no componente
         * @param conteudo Define o conteudo do alerta
         * @param tipoAlerta Define o style do alerta
         * @param duracao Define a duracao em segundos que o alerta ficará visivel para o usuario. Padra 3000 '3s'
         * @param icone Define um icone para ser exibido no alerta
         * @return a instancia do alerta criado e exibido;
         */
        public static function show(titulo:String, conteudo:String, tipoAlerta:int = 0, icone:Class = null, duracao:int=3000):Alerta {
            var alerta:Alerta = new Alerta();
            alerta._titulo 	 = titulo;
            alerta._conteudo = conteudo;
            alerta._icone 	 = icone;
            alerta._duracao  = duracao;
 
            /* Define o Style do Alerta pelo tipo.
             * O padrao será sempre o bgSucesso */
             
             switch(tipoAlerta)
             {
             	case ALERTA_SUCESSO:
             		alerta.setStyle('styleName', 'bgSucesso');
             		alerta._icone = ImageUtil.icon_sucesso;
             		break;
             	case ALERTA_WARNING:
             		alerta.setStyle('styleName', 'bgWarning');
             		alerta._icone = ImageUtil.icon_warning;
             		break;
             	case ALERTA_ERRO:
             		alerta.setStyle('styleName', 'bgErro');
             		alerta._icone = ImageUtil.icon_erro;
             		break;
             }
 			
            /* Exibe o alerta na tela */
            PopUpManager.addPopUp(alerta, DisplayObject(Application.application), false);
 
            /* Avisa o gerenciador que foi criado um novo alerta */
            GerenciadorAlerta.getInstance().alertaCriado();
 
            return alerta;
			
		}

	}
}