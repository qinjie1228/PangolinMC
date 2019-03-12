package com.plmc.util;

public class EntityConstantUtil {
	//页面
	/**
	 * 一页的数据条数
	 */
	public final static int PAGE_SIZE = 5;
	
	//登录状态
	/**
	 * 登录用户为会员权限
	 */
	public final static int CURRENTUSER_USER_STATE = 1;
	/**
	 * 登录用户为管理员权限
	 */
	public final static int CURRENTUSER_ADMIN_STATE = 2;
	
	//用户状态
	/**
	 * 初级会员
	 */
	public final static int USER_PRIMARY_STATE = 1;
	/**
	 * 中级会员
	 */
	public final static int USER_SECONDARY_STATE = 2;
	/**
	 * 高级会员
	 */
	public final static int USER_SUPERIOR_STATE = 3;
	/**
	 * 管理员
	 */
	public final static int USER_ADMIN_STATE = 4;
	/**
	 * 系统管理员
	 */
	public final static int USER_ADMIN_SYSTEM_STATE = 5;
	/**
	 * 过期用户
	 */
	public final static int USER_OVERDUE_STATE = 6;
	
	
	//活动状态
	/**
	 * 待审核活动
	 */
	public final static int ACT_WAITINGCHECK_STATE = 1;
	/**
	 * 已发布活动
	 */
	public final static int ACT_PUBLISHED_STATE = 2;
	/**
	 * 管理员已否决活动
	 */
	public final static int ACT_FAILCHECK_STATE = 3;
	/**
	 * 过期活动
	 */
	public final static int ACT_OVERDUE_STATE = 4;
	
	
	//活动预约记录状态
	/**
	 * 待审核活动预约记录
	 */
	public final static int MACT_WAITINGCHECK_STATE = 1;
	/**
	 * 审核已通过活动预约记录
	 */
	public final static int MACT_PASSRESERVE_STATE = 2;
	/**
	 * 管理员已否决活动预约记录
	 */
	public final static int MACT_FAILRESERVE_STATE = 3;
	/**
	 * 过期活动预约记录
	 */
	public final static int MACT_OVERDUE_STATE = 4;
	
	
	
	//道具状态
	/**
	 * 在售道具
	 */
	public final static int TOOL_SALING_STATE = 1;
	/**
	 * 过期道具
	 */
	public final static int TOOL_OVERDUE_STATE = 2;
	
	
	
	//订单状态
	/**
	 * 未确认订单/还在购物车订单
	 */
	public final static int ORDER_CART_STATE = 5;
	/**
	 * 已确认，等待支付订单/还在购物车订单
	 */
	public final static int ORDER_CART_CONFIRM_STATE = 6;
	/**
	 * 待审核订单
	 */
	public final static int ORDER_WAITINGCHECK_STATE = 1;
	/**
	 * 审核通过/已支付订单
	 */
	public final static int ORDER_PASSPAY_STATE = 2;
	/**
	 * 已发货订单
	 */
	public final static int ORDER_SEND_STATE = 3;
	/**
	 * 过期订单
	 */
	public final static int ORDER_OVERDUE_STATE = 4;
	
	
	
	//订单项目状态
	/**
	 * 正常订单项目
	 */
	public final static int TOOLORDER_NORMAL_STATE = 1;
	/**
	 * 过期订单项目
	 */
	public final static int TOOLORDER_OVERDUE_STATE = 2;
	
	
	
	//帖子状态
	/**
	 * 普通帖子
	 */
	public final static int POST_COMMON_STATE = 1;
	/**
	 * 精品帖子
	 */
	public final static int POST_WELLCHOSEN_STATE = 2;
//	/**
//	 * 热门帖子
//	 */
//	public final static int POST_HOT_STATE = 3;
	/**
	 * 置顶帖子
	 */
	public final static int POST_TOP_STATE = 4;
	/**
	 * 过期帖子
	 */
	public final static int POST_OVERDUE_STATE = 5;
	/**
	 * 待审核精品帖子
	 */
	public final static int POST_WAITINGCHECK_STATE = 6;
	
	
	
	//评语状态
	/**
	 * 已发布评语
	 */
	public final static int COMMENT_PUBLISHED_STATE = 1;
	/**
	 * 过期评语
	 */
	public final static int COMMENT_OVERDUE_STATE = 2;
	
	
	
	//公告状态
	/**
	 * 已发布公告
	 */
	public final static int NOTICE_PUBLISHED_STATE = 1;
	/**
	 * 过期公告
	 */
	public final static int NOTICE_OVERDUE_STATE = 2;
	
	
	
	//照片状态
	/**
	 * 普通照片
	 */
	public final static int PIC_COMMON_STATE = 1;
	/**
	 * 我喜欢的/收藏的照片
	 */
	public final static int PIC_MYLOVE_STATE = 2;
	/**
	 * 待审核精品照片
	 */
	public final static int PIC_WAITINGCHECK_STATE = 3;
	/**
	 * 精品照片
	 */
	public final static int PIC_WELLCHOSEN_STATE = 4;
	/**
	 * 过期照片
	 */
	public final static int PIC_OVERDUE_STATE = 5;
	
	
}
