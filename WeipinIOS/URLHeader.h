//
//  URLHeader.h
//  WeipinIOS
//
//  Created by haicuan139 on 14-7-2.
//  Copyright (c) 2014年 haicuan139. All rights reserved.
//

#define WURL_BASE_URL  @"http://www.vpinbao.com/"
/**
 * 面试信息列表
 */
#define WURL_ORAL_LIST @"oralinfo/queryList.ac"
/**
 * 没有头像的地址
 */
#define WURL_COMMIT_USER_INFO @"user/save.ac"
/**
 *带头像参数的地址
 */
#define WURL_COMMIT_USERINFO_HEADERIMAGE @"user/register.ac"
/**
 * 验证短信
 */
#define WURL_SEND_TEL_MESSAGE @"push/pushshortinfo.ac"
/**
 * 更新用户资料
 */
#define WURL_UPDATE_USER_INFO @"user/update.ac"

/**
 * App更新地址
 */
#define WURL_UPDATE_APK @"wp/apk/version.txt"

/**
 * 投递
 */
#define WURL_OREL_TOUDI @"oralinfo/applyoral.ac"
/**
 * 建议反馈
 */
#define WURL_URL_FEEDBACK @"feedback/save.ac"

/**
 * 评分
 */
#define WURL_URL_USER_SCORE @"userscore/findbyuserid.ac"

/**
 * POST参数：电话号码
 */

#define WPOST_PARAMS_TEL @"userTel"

/**
 * POST参数：userName
 */
//"userName",
//"userIdentitycard", "userSalary", "userWork", "userStatus"
#define WPOST_PARAMS_USERNAME @"userName"
#define WPOST_PARAMS_IDCARD @"userIdentitycard"
#define WPOST_PARAMS_SALARY @"userSalary"
#define WPOST_PARAMS_WORK_TYPE @"userWork"
#define WPOST_PARAMS_USER_STATE @"userStatus"
#define WPOST_REQUEST_CODE @"code"
#define WCONFIGKEY_USERID @"userId"

//面试信息字段
//id
#define WKEY_ORALINFO_ID @"oralId"
//面试状态
#define WKEY_ORALINFO_REST @"oralRst"
//创建时间
#define WKEY_ORALINFO_TIME @"createTime"
//公司名称
#define WKEY_ORALINFO_COMPANYNAME @"companyName"
//公司地址
#define WKEY_ORALINFO_COMPANADDRESS @"companyAddress"
//职位
#define WKEY_ORALINFO_GANGWEI @"hireTitle"
//薪酬
#define WKEY_ORALINFO_SALARY @"salay"
//电话
#define WKEY_ORALINFO_TEL @"comTel"

//面试时间
#define WKEY_ORALINFO_ORALTIME @"oralTime"

//联系人
#define WKEY_LINKMAN @"comLinkman"
//录用时间
#define WKEY_EMP_TIME @"empTime"
//录用地址
#define WKEY_EMP_ADDR @"empAddress"
//工作类型
#define WKEY_WORK_TYPE @"hireType"
//工作年限
#define WKEY_WORK_YEAR @"workYear"








