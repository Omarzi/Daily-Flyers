import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:photo_view/photo_view.dart';

class AllPhotosScreen extends StatefulWidget {
  const AllPhotosScreen({super.key, required this.map});

  final Map map;

  @override
  State<AllPhotosScreen> createState() => _AllPhotosScreenState();
}

class _AllPhotosScreenState extends State<AllPhotosScreen> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DColors.greyScale50,
      body: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              height: 75.h,
              color: DColors.primaryColor500,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  InkWellWidget(onTap: () => context.pop(), child: Icon((Icons.arrow_back), color: DColors.whiteColor)),
                  SizedBox(width: 16.w),
                  Text(AppLocalizations.of(context)!.isEnLocale ? widget.map['titleEn'] : widget.map['titleAr'], style: DStyles.h4Bold.copyWith(color: DColors.whiteColor)),
                ],
              ),
            ),

            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: images.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: PhotoView(
                          imageProvider: NetworkImage(url),
                          backgroundDecoration: BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '${_currentIndex + 1}/${images.length} ${AppLocalizations.of(context)!.translate('page')}',
              style: DStyles.bodyLargeBold,
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

