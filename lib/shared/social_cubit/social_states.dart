abstract class SocialStates{}

class SocialInitialStates extends SocialStates{}

class SocialLoadingStates extends SocialStates{}

class SocialSuccessStates extends SocialStates{}

class SocialErrorStates extends SocialStates{
  final String error;

  SocialErrorStates(this.error);
}

class SocialChangeNavBarStates extends SocialStates{}

class SocialNewPostStates extends SocialStates{}

class SocialProfileImagePickedLoadingStates extends SocialStates{}

class SocialProfileImagePickedSuccessStates extends SocialStates{}

class SocialProfileImagePickedErrorStates extends SocialStates{}

class SocialCoverImagePickedLoadingStates extends SocialStates{}

class SocialCoverImagePickedSuccessStates extends SocialStates{}

class SocialCoverImagePickedErrorStates extends SocialStates{}

class SocialUploadProfileImageSuccessStates extends SocialStates{}

class SocialUploadProfileImageErrorStates extends SocialStates{}

class SocialUploadCoverImageSuccessStates extends SocialStates{}

class SocialUploadCoverImageErrorStates extends SocialStates{}

class SocialUserUpdateLoadingStates extends SocialStates{}
class SocialUserUpdateErrorStates extends SocialStates{}

class SocialCreatePostLoadingStates extends SocialStates{}
class SocialCreatePostSuccessStates extends SocialStates{}
class SocialCreatePostErrorStates extends SocialStates{}

class SocialPostImagePickedSuccessStates extends SocialStates{}
class SocialPostImagePickedErrorStates extends SocialStates{}

class SocialRemovePostImageSuccessStates extends SocialStates{}


class SocialGetPostsLoadingStates extends SocialStates{}

class SocialGetPostsSuccessStates extends SocialStates{}

class SocialGetPostsErrorStates extends SocialStates{
  final String error;

  SocialGetPostsErrorStates(this.error);
}


class SocialLikePostSuccessStates extends SocialStates{}

class SocialLikePostErrorStates extends SocialStates{
  final String error;

  SocialLikePostErrorStates(this.error);
}

class SocialCommentsPostLoadingStates extends SocialStates{}

class SocialCommentsPostSuccessStates extends SocialStates{}

class SocialCommentsPostErrorStates extends SocialStates{
  final String error;

  SocialCommentsPostErrorStates(this.error);
}

class SocialGetAllUserLoadingStates extends SocialStates{}

class SocialGetAllUserSuccessStates extends SocialStates{}

class SocialGetAllUserErrorStates extends SocialStates{
  final String error;

  SocialGetAllUserErrorStates(this.error);
}


class SocialGetAllUserStates extends SocialStates{}



class SocialSendMessageSuccessStates extends SocialStates{}

class SocialSendMessageErrorStates extends SocialStates{
  final String error;

  SocialSendMessageErrorStates(this.error);
}


class SocialGetMessageSuccessStates extends SocialStates{}

class SocialCreateMessageErrorStates extends SocialStates{
  final String error;

  SocialCreateMessageErrorStates(this.error);
}

class SocialGetCommentsSuccessStates extends SocialStates{}


class SocialMessageImagePickedSuccessStates extends SocialStates{}

class SocialMessageImagePickedErrorStates extends SocialStates{}