
$(function(){


    // Definição das opções de entrada para gerar a senha

    let letmin = $("input#letras_min");

    let letmai = $("input#letras_mai");

    let caresp = $("input#carac_especiais");

    // Mapeamento dos caracteres da senha pela tabela ASCII

    let corrASCII = {
        "33": "!",
        "34": "\"",
        "35": "#",
        "36": "$",
        "37": "%",
        "38": "&",
        "39": "'",
        "40": "(",
        "41": ")",
        "42": "*",
        "43": "+",
        "44": ",",
        "45": "-",
        "46": ".",
        "47": "/",
        "48": "0",
        "49": "1",
        "50": "2",
        "51": "3",
        "52": "4",
        "53": "5",
        "54": "6",
        "55": "7",
        "56": "8",
        "57": "9",
        "58": ":",
        "59": ";",
        "60": "<",
        "61": "=",
        "62": ">",
        "63": "?",
        "64": "@",
        "65": "A",
        "66": "B",
        "67": "C",
        "68": "D",
        "69": "E",
        "70": "F",
        "71": "G",
        "72": "H",
        "73": "I",
        "74": "J",
        "75": "K",
        "76": "L",
        "77": "M",
        "78": "N",
        "79": "O",
        "80": "P",
        "81": "Q",
        "82": "R",
        "83": "S",
        "84": "T",
        "85": "U",
        "86": "V",
        "87": "W",
        "88": "X",
        "89": "Y",
        "90": "Z",
        "91": "[",
        "92": "\\",
        "93": "]",
        "94": "^",
        "95": "_",
        "96": "`",
        "97": "a",
        "98": "b",
        "99": "c",
        "100": "d",
        "101": "e",
        "102": "f",
        "103": "g",
        "104": "h",
        "105": "i",
        "106": "j",
        "107": "k",
        "108": "l",
        "109": "m",
        "110": "n",
        "111": "o",
        "112": "p",
        "113": "q",
        "114": "r",
        "115": "s",
        "116": "t",
        "117": "u",
        "118": "v",
        "119": "w",
        "120": "x",
        "121": "y",
        "122": "z",
        "123": "{",
        "124": "|",
        "125": "}",
        "126": "~"
    };

    function gerarNumerosAleatorios(comp,min,max){
        
        // Parâmetros básicos para uso no AJAX
        var par = [comp,min,max];

        // Requisição HTTP GET ao gerador de números inteiros aleatórios do site random.org
        $('#loadingmsg').show();
        $.ajax({
            "type": "GET",
            "url": "https://www.random.org/integers/?num=" + par[0] + "&min=" + par[1] + "&max=" + par[2] + "&col=1&base=10&format=plain&rnd=new", 
            "success": function(data){
                var resp = data;
                $('#loadingmsg').hide();
                construirSenha(resp,corrASCII);
            },
            "error": function(){
                $("#senha").html("Falha na requisição");
                $('#loadingmsg').hide();
            }   
        });

    }

    function construirSenha(resp,corrASCII){

        // Coleta da lista de números inteiros obtidos como resposta no formato de string
        var list_str = resp.split("\n");
        list_str = list_str.slice(0,(list_str.length-1));

        // Conversão da lista de números inteiros obtidos para o formato numérico
        var list_num = [];

        for (var a = 0; a < list_str.length; a++) {

            list_num.push(parseInt(list_str[a]));

        }

        // Testes para mapeamento correto dos caracteres desejados de acordo com a tabela ASCII
        if(!letmin.is(':checked') && !letmai.is(':checked') && !caresp.is(':checked')){
            
            // min = 48, max = 57

            list_num = list_num;

        } else if(letmin.is(':checked') && !letmai.is(':checked') && !caresp.is(':checked')){

            // min = 48, max = 83

            for (var b = 0; b < list_num.length; b++) {

                if(list_num[b] > 57){

                    list_num[b] = list_num[b] + 39;

                } else {

                    list_num[b] = list_num[b];

                }

            }

        } else if(!letmin.is(':checked') && letmai.is(':checked') && !caresp.is(':checked')){

            // min = 48, max = 83

            for (var b = 0; b < list_num.length; b++) {

                if(list_num[b] > 57){

                    list_num[b] = list_num[b] + 7;

                } else {

                    list_num[b] = list_num[b];

                }

            }

        } else if(!letmin.is(':checked') && !letmai.is(':checked') && caresp.is(':checked')){
            
            // min = 33, max = 74

             for (var b = 0; b < list_num.length; b++) {

                if(list_num[b] > 64 && list_num[b] <= 70){

                    list_num[b] = list_num[b] + 26;

                } else if (list_num[b] > 70){

                    list_num[b] = list_num[b] + 52;

                } else {

                    list_num[b] = list_num[b];

                }

            }

        } else if(letmin.is(':checked') && letmai.is(':checked') && !caresp.is(':checked')){

            // min = 48, max = 109

             for (var b = 0; b < list_num.length; b++) {

                if(list_num[b] > 57 && list_num[b] <= 83){

                    list_num[b] = list_num[b] + 7;

                } else if (list_num[b] > 83){

                    list_num[b] = list_num[b] + 13;

                } else {

                    list_num[b] = list_num[b];

                }

            }

        } else if(letmin.is(':checked') && !letmai.is(':checked') && caresp.is(':checked')){
     
            // min = 33, max = 100

            for (var b = 0; b < list_num.length; b++) {

                if(list_num[b] > 64){

                    list_num[b] = list_num[b] + 26;

                } else {

                    list_num[b] = list_num[b];

                }

            }

        } else if(!letmin.is(':checked') && letmai.is(':checked') && caresp.is(':checked')){

            // min = 33, max = 100

            for (var b = 0; b < list_num.length; b++) {

                if(list_num[b] > 96){

                    list_num[b] = list_num[b] + 26;

                } else {

                    list_num[b] = list_num[b];

                }

            }

        } else {

            // min = 33, max = 126

            list_num = list_num;

        }


        // Concatenação dos caracteres obtidos para formar a senha
        var pass = "";

        for (var c = 0; c < list_num.length; c++) {

            pass = pass + corrASCII[list_num[c]];

        }

        // Exibição da senha gerada
        $("#senha").html("<strong>" + pass + "</strong>");

    }
 

    // Mapeamento do evento de clique em gerar senha 
    $("#gerar").click(function(){  

        // Coleta dinâmica do comprimento da senha selecionado
        var comp = $("#comp-disp").text();

        // Coleta das diferentes opções de caracteres nas senhas
        if(!letmin.is(':checked') && !letmai.is(':checked') && !caresp.is(':checked')){
            
            var min = "48";
            var max = "57";

            gerarNumerosAleatorios(comp,min,max);

        } else if(letmin.is(':checked') && !letmai.is(':checked') && !caresp.is(':checked')){

            var min = "48";
            var max = "83";

            gerarNumerosAleatorios(comp,min,max);

        } else if(!letmin.is(':checked') && letmai.is(':checked') && !caresp.is(':checked')){

            var min = "48";
            var max = "83";

            gerarNumerosAleatorios(comp,min,max);

        } else if(!letmin.is(':checked') && !letmai.is(':checked') && caresp.is(':checked')){
            
            var min = "33";
            var max = "74";

            gerarNumerosAleatorios(comp,min,max);

        } else if(letmin.is(':checked') && letmai.is(':checked') && !caresp.is(':checked')){

            var min = "48";
            var max = "109";

            gerarNumerosAleatorios(comp,min,max);

        } else if(letmin.is(':checked') && !letmai.is(':checked') && caresp.is(':checked')){
     
            var min = "33";
            var max = "100";

            gerarNumerosAleatorios(comp,min,max);

        } else if(!letmin.is(':checked') && letmai.is(':checked') && caresp.is(':checked')){

            var min = "33";
            var max = "100";

            gerarNumerosAleatorios(comp,min,max);

        } else {

            var min = "33";
            var max = "126";

            gerarNumerosAleatorios(comp,min,max);

        }

    });

});