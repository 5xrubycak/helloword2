# README
Model：User 
欄位名稱 資料型態 說明 
name string 姓名  
email string 電郵

Model：Setbox 
欄位名稱 資料型態 說明 
title string 學習集名稱  
user_id integer 擁有此學習集的user編號

Model：Card
欄位名稱 資料型態 說明 
card_word string 單字
card_def string 定義
setbox_id integer 對應此單字的set編號
