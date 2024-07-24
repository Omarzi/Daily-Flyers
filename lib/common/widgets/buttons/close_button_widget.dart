import '../../../utils/constants/exports.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: (){
            context.pop();
          },
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: DColors.greyScale500,
            child: Center(
              child: Icon(Icons.close,color: DColors.greyScale500,size: 20.sp,),
            ),
          ),
        ),
      ],
    );
  }
}