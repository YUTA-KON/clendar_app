// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//
//= require jquery
//= require moment
//= require fullcalendar

$(function () {
    // 画面遷移を検知
    $(document).on('turbolinks:load', function () {
        if ($('#calendar').length) {

            function Calendar() {
                return $('#calendar').fullCalendar({
                });
            }
            function clearCalendar() {
                $('#calendar').html('');
            }

            $(document).on('turbolinks:load', function () {
                Calendar();
            });
            $(document).on('turbolinks:before-cache', clearCalendar);

            //events: '/plans.json'
            $('#calendar').fullCalendar({
                events: '/plans.json',
                //カレンダー上部を年月で表示させる
                titleFormat: 'YYYY年 M月',
                //曜日を日本語表示
                dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
                //ボタンのレイアウト
                header: {
                    left: 'today prev,next',
                    center: 'title',
                    right: 'month, agendaWeek, agendaDay'
                },
                //終了時刻がないイベントの表示間隔
                defaultTimedEventDuration: '03:00:00',
                buttonText: {
                    prev: '前',
                    next: '次',
                    prevYear: '前年',
                    nextYear: '翌年',
                    today: '今日',
                    month: '月',
                    week: '週',
                    day: '日'
                },
                // Drag & Drop & Resize
                editable: true,
                //イベントの時間表示を２４時間に
                timeFormat: "HH:mm",
                //イベントの色を変える
                eventColor: '#87cefa',
                //イベントの文字色を変える
                eventTextColor: '#000000',
                eventRender: function(event, element) {
                    element.css("font-size", "0.8em");
                    element.css("padding", "5px");
                },
                // カレンダーへの追加でイベント保存
                navLinks: true,
                selectable: true,
                selectHelper: true,

                //作成
                select: function(start, end) {
                    var title = prompt('イベントを追加');
                    if (title) {
                        // CSRF Token
                        $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
                            var token;
                            if (!options.crossDomain) {
                                token = $('meta[name="csrf-token"]').attr('content');
                                if (token) {
                                    return jqXHR.setRequestHeader('X-CSRF-Token', token);
                                }
                            }
                        });
                        $.ajax({
                            type: "post",
                            url: "/plans",
                            data: JSON.stringify({
                                title: title,
                                start_time: start.toISOString(),
                                finish_time: end.toISOString()
                            }),
                            contentType: 'application/JSON'
                        });
                    }
                },

                //ドラッグ
                eventDrop: function(info){
                    // CSRF Token
                    $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
                        var token;
                        if (!options.crossDomain) {
                            token = $('meta[name="csrf-token"]').attr('content');
                            if (token) {
                                return jqXHR.setRequestHeader('X-CSRF-Token', token);
                            }
                        }
                    });
                    $.ajax({
                        type: "patch",
                        url:"plans/"+info.id,
                        data: JSON.stringify({
                            start_time: info.start.toISOString(),
                            finish_time: info.end.toISOString()
                        }),
                        contentType: 'application/JSON'
                    });
                },

                //リサイズ
                eventResize: function(eventResizeinfo){
                    // CSRF Token
                    $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
                        var token;
                        if (!options.crossDomain) {
                            token = $('meta[name="csrf-token"]').attr('content');
                            if (token) {
                                return jqXHR.setRequestHeader('X-CSRF-Token', token);
                            }
                        }
                    });
                    $.ajax({
                        type: "patch",
                        url:"plans/"+eventResizeinfo.id,
                        data: JSON.stringify({
                            start_time: eventResizeinfo.start.toISOString(),
                            finish_time: eventResizeinfo.end.toISOString()
                        }),
                        contentType: 'application/JSON'
                    });
                }
            });
        }
    });
});