<!-- このコードを "index_template.tpl" という名前のファイルとして保存してください -->

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>席の予約システム</title>
    <style>
        .seat {
            padding: 10px 20px;
            margin: 10px;
            border: 2px solid #000;
            display: inline-block;
            cursor: pointer;
        }

        .reserved {
            background-color: #FFD700;
        }
    /* ... その他のスタイル ... */
    .seat[disabled] {
        cursor: not-allowed;
        opacity: 0.5;
    }        
    </style>
</head>
<body>

<div id="seats">
    % for i in range(1, 26):
        % if i in yoyaku_seki:
            <div class="seat reserved" disabled>席{{i}}</div>
        % else:
            <div class="seat" onclick="reserveSeat({{i}})">席{{i}}</div>
        % end
    % end
</div>

<button onclick="confirmReservation()">予約決定</button>

<script>
    let selectedSeatNumber = null;

    function reserveSeat(seatNumber) {
        if (selectedSeatNumber) {
            document.querySelector(`#seats .seat:nth-child(${selectedSeatNumber})`).classList.remove('reserved');
        }
        document.querySelector(`#seats .seat:nth-child(${seatNumber})`).classList.add('reserved');
        selectedSeatNumber = seatNumber;
    }

    function confirmReservation() {
        if (selectedSeatNumber) {
            fetch('/yoyaku', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `seat_number=${selectedSeatNumber}`
            })
            .then(response => response.text())
            .then(data => {
                alert(data);
            });
        } else {
            alert("席を選択してください。");
        }
    }
</script>

</body>
</html>
