class LogicalEntity
{
  String expression;
  String label;
}

class LinkLogicalEntity extends LogicalEntity
{
  LinkLogicalEntity(this.from, this.to){
  }

  LogicalEntity from;
  LogicalEntity to;
}