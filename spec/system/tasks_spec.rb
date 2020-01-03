require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # memo
  # user_a = FactoryBot.create(:user)  # Factoryからテストユーザーをデータベースに作製
  # user_x = FactoryBot.build(:user) Factorybot.build はデータベースに登録する直前で止めて未保存のオブジェクトが得られるmethod
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }
  
  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'show task that userA create' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている' do
      let(:login_user) { user_a }

      it_behaves_like 'show task that userA create'
    end

    context 'ユーザーBがログインしている' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'show task that userA create'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '登録する'
    end

    context '名称を入力する' do
      let(:task_name) { '新規作成のテストを書く' } 

      it '正常に処理完了' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '名称を空欄にする' do
      let(:task_name) { '' }

      it 'エラーになる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end