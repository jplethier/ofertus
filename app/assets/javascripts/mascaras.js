function mascara_trapenter(o,f,e,trap,clean) {
      if (!e) e = window.event;
      if (e.keyCode == 13) {
            e.cancelBubble = true;
            if (e.returnValue) e.returnValue = false;
            if (e.stopPropagation) e.stopPropagation();

            trap(o.value);
      if (clean == true) {
        o.value = '';
      }
      o.focus();
            return false;
      } else {
      mascara(o,f);
      }
}

function mascara(o,f){
  v_obj=o
  v_fun=f
  setTimeout("execmascara()",1)
}

function execmascara(){
  v_obj.value=v_fun(v_obj.value)
}

function porcento(v) {
  v=parseFloat(decimal(v));
  if (v > 100) { v = 100; }
  return FComma(decimal(v));
}

function juros(v) {
  return FComma(decimal_comsinal(v))
}

function money(v) {
  var sign = '';
  if (/\-/.test(v)) {
    sign = '-';
  }
  return sign + FComma(decimal(v))
}

function alfaupper(v) {
  v=v.replace(/[^a-z ]/gi,"")
  v=v.toUpperCase()
  return v
}

function alfanumupper(v) {
  v=v.replace(/\W/,"")
  v=v.toUpperCase()
  return v
}

function alfalower(v) {
  v=v.replace(/[^a-z]/gi,"")
  v=v.toLowerCase()
  return v
}

function alfanum(v){
  v=v.replace(/\W/g,"")
  v=v.toUpperCase()
  return v
}

function documento(v){
  v=v.replace(/[^\d\-\\\(\).\/]/g,"") //Remove tudo o que nao e digito
  return v
}

function email(v){
  v=v.replace(/[^\w\@\.-]/g,"") // remove tudo que nao eh alfanum, @ e ponto e -
  v=v.replace(/\@\@/g,".") // remove @ duplos
  v=v.replace(/\.\./g,".") // remove pontos duplos
  v=v.replace(/^\@/g,"") // remove @ no comeco
  v=v.replace(/^\./g,"") // remove pontos no comeco
  return v
}

function numero(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  return v
}

function numero_comsinal(v){
  v=v.replace(/[^-\d]/g,"") //Remove tudo o que nao e digito
  if (v.indexOf('-') >= 0) {
    v='-'+v.replace(/\D/g,'')
  }
  return v
}

function decimal_comsinal(v){
  v=v.replace(/[^-\d]/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^0/g,"") //Remove tudo o que nao e digito

  if (v.indexOf('-') >= 0) {
    v='-'+v.replace(/\D/g,'')
  }

  // coloca decimal
  if (v.length <= 2) {
    v="0.0"+v
  } else if (v.length == 2) {
    v="0."+v
  } else {
    v=v.replace(/(\d)(\d{2})$/g,"$1,$2") // coloca decimal
  }
  return v
}

function decimal(v){
  v=v+'';
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^0/g,"") //Remove tudo o que nao e digito

  // remove ponto e virgula
  v=v.replace('.', "")
  v=v.replace(',', "")

  // coloca decimal
  if (v.length <= 2) {
    v="0.0"+v
  } else if (v.length == 2) {
    v="0."+v
  } else {
    v=v.replace(/(\d)(\d{2})$/g,"$1.$2") // coloca decimal
  }
  return v
}

function datahora(v){
  return data(v.substr(0,11)) + ' ' + hora(v.substr(11,5));
}

function dia(v) {
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^[4-9]$/,"3")
  v=v.replace(/^3[2-9]$/,"31")
  return v
}

function data(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^(\d{2})(\d)/g,"$1/$2") //Coloca barra entre 3o e 4o digitos
  v=v.replace(/^(\d{2})\/(\d{2})(\d)/g,"$1/$2/$3") //Coloca barra entre 9o e 10o digitos
  v=v.replace(/^[3][2-9]\//,"31/")
  v=v.replace(/^[4-9][0-9]\//,"31/")
  v=v.replace(/\/[1-2][3-9]\//,"/12/")
  v=v.replace(/\/[3-9][0-9]\//,"/12/")
  return v
}

function hora(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^(\d{2})(\d)/g,"$1:$2") //Coloca : entre 3o e 4o digitos
  v=v.replace(/:[6-9]$/,":")
  v=v.replace(/^[3-9]$/,"")
  v=v.replace(/^2[4-9]$/,"2")
  return v
}

function tempo(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^(\d{2})(\d{2})(\d)/g,"$1:$2:$3") //Coloca : entre 3o e 4o digitos
  v=v.replace(/^(\d{2})(\d)/g,"$1:$2") //Coloca : entre 3o e 4o digitos
  return v
}

function telefone(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/(\d{2})(\d*)/, "($1) $2") // coloca parentesis nos primeiros dois digitos
  v=v.replace(/(\(\d{2}\) )(\d{4})(\d*)/, "$1$2-$3") // coloca hifen
  return v
}

function telefone_sem_ddd(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/(\d{4})(\d*)/, "$1-$2") // coloca hifen
  return v
}

function maiusculas(v){
  v=v.toUpperCase()
  return v
}

function cpf(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/(\d{3})(\d)/,"$1.$2") //Coloca um ponto entre o terceiro e o quarto digitos
  v=v.replace(/(\d{3})(\d)/,"$1.$2") //Coloca um ponto entre o terceiro e o quarto digitos
  //de novo (para o segundo bloco de numeros)
  v=v.replace(/(\d{3})(\d{1,2})$/,"$1-$2") //Coloca um hifen entre o terceiro e o quarto digitos
  return v
}

function cep(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^(\d{5})(\d)/,"$1-$2") //Esse e tao facil que nao merece explicacoes
  return v
}

function cnpj(v){
  v=v.replace(/\D/g,"") //Remove tudo o que nao e digito
  v=v.replace(/^(\d{2})(\d)/,"$1.$2") //Coloca ponto entre o segundo e o terceiro digitos
  v=v.replace(/^(\d{2})\.(\d{3})(\d)/,"$1.$2.$3") //Coloca ponto entre o quinto e o sexto digitos
  v=v.replace(/\.(\d{3})(\d)/,".$1/$2") //Coloca uma barra entre o oitavo e o nono digitos
  v=v.replace(/(\d{4})(\d)/,"$1-$2") //Coloca um hifen depois do bloco de quatro digitos
  return v
}

function permalink(v) {
  v=v.replace(/[^a-z|A-Z|0-9| |\-]/,'');
  v=v.replace(/ +/g,'-');
  v=v.toLowerCase();
  return v;
}