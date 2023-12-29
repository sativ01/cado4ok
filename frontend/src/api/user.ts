export type UserType = "admin" | "teacher" | "parent";

export const Role: Record<UserType, string> = {
  admin: "ADMIN",
  teacher: "TEACHER",
  parent: "PARENT"
}

export type Child = {
  id: string,
  parentId: string,
  name: string,
  parentNote: string,
  hasDailyLunch: boolean,
}

export type User = {
  id: string,
  name: string,
  email: string,
  phone: string,
  child: Child[],
  userType: UserType,
  note: string
}

export type ChildExcuseData = {
  childId: string,
  note: string,
}

export type DayStats = {
  childrenExcused: ChildExcuseData[],
  lunchCountExcused: number,
  childrenEnrolled: ChildExcuseData[],
}

export type UserActions = "addParent" | "addChild" | "excuseChild" | "enrollChild" | "cancelExcuse" | "cancelEnroll"

export const actionAccess: Record<UserActions, string[]> = {
  addParent: [Role.teacher, Role.admin, Role.parent],
  addChild: [Role.teacher, Role.admin, Role.parent],
  excuseChild: [Role.teacher, Role.admin, Role.parent],
  enrollChild: [Role.teacher, Role.admin, Role.parent],
  cancelEnroll: [Role.teacher, Role.admin, Role.parent],
  cancelExcuse: [Role.teacher, Role.admin, Role.parent],
}
