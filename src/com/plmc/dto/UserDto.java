package com.plmc.dto;


public class UserDto {
	private String userNo;
	private String userName;
	private String userPwd;
	private String userRealName;
	private String userAge;
	private String userSex;
	private String userAddress;
	private String userEmail;
	private String userPic;
	private String userRegTime;
	private String userState;
	public UserDto() {
		super();
	}
	
	public UserDto(String userNo, String userName, String userPwd, String userRealName, String userAge, String userSex, String userAddress,
			String userEmail, String userPic, String userRegTime, String userState) {
		super();
		this.userNo = userNo;
		this.userName = userName;
		this.userPwd = userPwd;
		this.userRealName = userRealName;
		this.userAge = userAge;
		this.userSex = userSex;
		this.userAddress = userAddress;
		this.userEmail = userEmail;
		this.userPic = userPic;
		this.userRegTime = userRegTime;
		this.userState = userState;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserRealName() {
		return userRealName;
	}
	public void setUserRealName(String userRealName) {
		this.userRealName = userRealName;
	}
	public String getUserAge() {
		return userAge;
	}
	public void setUserAge(String userAge) {
		this.userAge = userAge;
	}
	public String getUserSex() {
		return userSex;
	}
	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPic() {
		return userPic;
	}
	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}
	public String getUserRegTime() {
		return userRegTime;
	}
	public void setUserRegTime(String userRegTime) {
		this.userRegTime = userRegTime;
	}
	public String getUserState() {
		return userState;
	}
	public void setUserState(String userState) {
		this.userState = userState;
	}

	@Override
	public String toString() {
		return "UserDto [userNo=" + userNo + ", userName=" + userName + ", userRealName=" + userRealName + ", userAge=" + userAge
				+ ", userSex=" + userSex + ", userAddress=" + userAddress + ", userEmail=" + userEmail + ", userPic="
				+ userPic + ", userRegTime=" + userRegTime + ", userState=" + userState + "]";
	}
	
}
