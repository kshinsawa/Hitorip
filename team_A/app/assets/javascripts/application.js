// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require flat-ui

$(function(){
    $('#tab-menu li').on('click', function(){
       if($(this).not('active')){
         // タブメニュー
         $(this).addClass('active').siblings('li').removeClass('active');
         // タブの中身
         var index = $('#tab-menu li').index(this);
         $('#tab-box div').eq(index).addClass('active').siblings('div').removeClass('active');
       }
    });
});

$(function(){
  $("#modal-open").click(function(){
    $(this).blur() ;	//ボタンからフォーカスを外す
    if($("#modal-overlay")[0])$("#modal-overlay").remove() ;		//現在のモーダルウィンドウを削除して新しく起動する
      //オーバーレイ用のHTMLコードを、[body]内の最後に生成する
      $("body").append('<div id="modal-overlay"></div>');
      //コンテンツをセンタリングする
	    centeringModalSyncer() ;
      //[$modal-overlay]をフェードインさせる
      $("#modal-overlay").fadeIn("slow");
      //[$modal-content]をフェードインさせる
      $("#modal-content").fadeIn("slow");

      $("#modal-overlay,#modal-close").unbind().click(function(){
        //[#modal-overlay]、または[#modal-close]をクリックしたら起こる処理
        //[#modal-overlay]と[#modal-close]をフェードアウトする
        $("#modal-content,#modal-overlay").fadeOut("slow",function(){
        //フェードアウト後、[#modal-overlay]をHTML(DOM)上から削除
        $("#modal-overlay").remove();});
      });
	  });
});

$( window ).resize( centeringModalSyncer ) ;
	//センタリングを実行する関数
	function centeringModalSyncer() {
		//画面(ウィンドウ)の幅、高さを取得
		var w = $( window ).width() ;
		var h = $( window ).height() ;
		// コンテンツ(#modal-content)の幅、高さを取得
		// jQueryのバージョンによっては、引数[{margin:true}]を指定した時、不具合を起こします。
//		var cw = $( "#modal-content" ).outerWidth( {margin:true} );
//		var ch = $( "#modal-content" ).outerHeight( {margin:true} );
		var cw = $( "#modal-content" ).outerWidth();
		var ch = $( "#modal-content" ).outerHeight();
		//センタリングを実行する
		$( "#modal-content" ).css( {"left": ((w - cw)/2) + "px","top": ((h - ch)/2) + "px"} ) ;
	}
