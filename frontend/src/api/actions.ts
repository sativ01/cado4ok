
import { Child, ChildExcuseData, User } from "./user";

type funcArgs = { user: User, parent: User, name: string, hasDailyLunch: boolean, note?: string };

export const addChildToParentRecord = ({ user, parent, name, hasDailyLunch, note }: funcArgs) => {
  // const canPerform = canPerformAction(user, actionName)
  const child: Child = {
    id: "000",
    parentId: parent.id,
    name,
    parentNote: note ?? "",
    hasDailyLunch
  }
  return child;
}

type excuseChildArgs = { user: User, childId: string, date: Date, note?: string };
export const excuseChild = ({ user, childId, date, note }: excuseChildArgs) => {
  const excuse: ChildExcuseData = {
    childId,
    note: note ?? ""
  }
  return excuse;
}
