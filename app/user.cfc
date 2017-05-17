component persistent="true"
{
  property name="userId" column="id" fieldtype="id" type="numeric" generator="increment";
  property name="userName";
  property name="firstName";
  property name="lastName";
  property name="hashedPassword";
  property name="passwordSalt";
  property name="email";
  property name="accountDisabled";
  property name="userGuid";
}
