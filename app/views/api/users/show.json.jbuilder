if @user.present? && @user.admin
    json.id @user.id
    if @user.admin
        json.admin true 
    else
        json.admin false
    end 
else
    json.admin false 
end
