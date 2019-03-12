package com.plmc.vo.entity;


import java.util.Date;

public class User extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userNo;
	private String userName;
	private String userPwd;
	private String userRealName;
	private int userAge;
	private int userSex;
	private String userAddress;
	private String userEmail;
	private String userPic;
	private Date userRegTime;
	private int userState;
	public User() {
		super();
	}
	public User(String userName, String userPwd) {
		super();
		this.userName = userName;
		this.userPwd = userPwd;
	}
	public User(String userName, String userPwd, int userAge, int userSex, String userEmail, Date userRegTime,
			int userState) {
		super();
		this.userName = userName;
		this.userPwd = userPwd;
		this.userAge = userAge;
		this.userSex = userSex;
		this.userEmail = userEmail;
		this.userRegTime = userRegTime;
		this.userState = userState;
	}
	public User(String userName, String userPwd, String userRealName, int userAge, int userSex, String userEmail,
			Date userRegTime, int userState) {
		super();
		this.userName = userName;
		this.userPwd = userPwd;
		this.userRealName = userRealName;
		this.userAge = userAge;
		this.userSex = userSex;
		this.userEmail = userEmail;
		this.userRegTime = userRegTime;
		this.userState = userState;
	}
	public User(String userName, String userPwd, String userRealName, int userAge, int userSex, String userAddress,
			String userEmail, Date userRegTime, int userState) {
		super();
		this.userName = userName;
		this.userPwd = userPwd;
		this.userRealName = userRealName;
		this.userAge = userAge;
		this.userSex = userSex;
		this.userAddress = userAddress;
		this.userEmail = userEmail;
		this.userRegTime = userRegTime;
		this.userState = userState;
	}
	public User(String userName, String userPwd, String userRealName, int userAge, int userSex, String userAddress,
			String userEmail, String userPic, Date userRegTime, int userState) {
		super();
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
	
	public User(String userNo, String userName, String userPwd, String userRealName, int userAge, int userSex,
			String userAddress, String userEmail, String userPic, Date userRegTime, int userState) {
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
	@Override
	public String toString() {
		return "User [userNo=" + userNo + ", userName=" + userName + ", userPwd=" + userPwd + ", userRealName="
				+ userRealName + ", userAge=" + userAge + ", userSex=" + userSex + ", userAddress=" + userAddress
				+ ", userEmail=" + userEmail + ", userPic=" + userPic + ", userRegTime=" + userRegTime + ", userState="
				+ userState + "]";
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
	public int getUserAge() {
		return userAge;
	}
	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}
	public int getUserSex() {
		return userSex;
	}
	public void setUserSex(int userSex) {
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
	public Date getUserRegTime() {
		return userRegTime;
	}
	public void setUserRegTime(Date userRegTime) {
		this.userRegTime = userRegTime;
	}
	public int getUserState() {
		return userState;
	}
	public void setUserState(int userState) {
		this.userState = userState;
	}
	
}
