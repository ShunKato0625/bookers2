class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])  # どのユーザーとチャットするかを取得。
    rooms = current_user.user_rooms.pluck(:room_id) # カレントユーザーのuser_roomにあるroom_idの値の配列をroomsに代入。
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    # user_roomモデルから
    # user_idがチャット相手のidが一致するものと、
    # room_idが上記roomsのどれかに一致するレコードを
    # user_roomsに代入。
    if user_rooms.nil?
      @room = Room.new # それ以外は新しくroomを作り、
      @room.save # user_roomをカレントユーザー分とチャット相手分を作る
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else # もしuser_roomが空でないなら
      @room = user_rooms.room  # @roomに上記user_roomのroomを代入
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end
end
