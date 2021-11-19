# frozen_string_literal: true
require 'rails_helper'

describe '投稿のテスト' do
  let!(:post_image) { create(:post_image, post_name:'hoge',caption:'body') }
  describe 'トップ画面(top_path)のテスト' do
    before do
      visit top_path
    end
    context '表示の確認' do
      it 'top_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "投稿画面(new_post_image_path)のテスト" do
    before do
      visit new_post_image_path
    end
    context '表示の確認' do
      it 'new_post_image_pathが"/post_images/new"であるか' do
        expect(current_path).to eq('/todolists/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post_image[post_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'post_image[caption]', with: Faker::Lorem.characters(number:20)
        click_button '投稿'
        expect(page).to have_current_path post_images_path(PostImage.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit post_images_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post_image.post_name
        expect(page).to have_link post_image.post_name
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit post_image_path(post_image)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/post_images/' + list.id.to_s + '/edit')
      end
    end
    context 'post_image削除のテスト' do
      it 'post_imageの削除' do
        expect{ post_image.destroy }.to change{ PostImage.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_image_path(post_image)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'post_image[post_name]', with: post_image.post_name
        expect(page).to have_field 'post_image[caption]', with: post_image.caption
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post_image[post_name]', with: Faker::Lorem.characters(number:5)
        fill_in 'post_image[caption]', with: Faker::Lorem.characters(number:20)
        click_button '保存'
        expect(page).to have_current_path post_images_path(post_image)
      end
    end
  end
end