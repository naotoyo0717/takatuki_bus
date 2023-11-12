from bottle import Bottle, route, run, template, request
import json

yoyaku_seki = []

try:
    with open('yoyaku_seki.json','r') as file:  
        yoyaku_seki = json.load(file)  # 予約済みの席をデータベースから取得
except FileNotFoundError:
    yoyaku_seki = []

app = Bottle()

@app.route('/')
def index():
    return template('index_template', yoyaku_seki=yoyaku_seki)

@app.route('/yoyaku', method='POST')
def yoyaku():
    seat_number = int(request.forms.get('seat_number'))
    # こちらで任意の処理を行う
    if seat_number in yoyaku_seki:
        print(f"席{seat_number}の予約が失敗しました")
        return "予約失敗"
    else:
        yoyaku_seki.append(seat_number)
        # データベースに保存
        with open('yoyaku_seki.json', 'w',encoding='utf-8') as file:
            json.dump(yoyaku_seki, file, ensure_ascii=False)
        print(f"席{seat_number}が予約されました！")
        return "予約完了"

if __name__ == "__main__":
    run(app, host='localhost', port=8080, reloader=True, debug=True)
