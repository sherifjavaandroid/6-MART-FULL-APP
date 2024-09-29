import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';

class ItemImageViewWidget extends StatelessWidget {
  final Item? item;
  final bool isCampaign;
  ItemImageViewWidget({super.key, required this.item, this.isCampaign = false});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {

    List<String?> imageList = [];
    List<String?> imageListForCampaign = [];

    if(isCampaign){
      imageListForCampaign.add(item!.imageFullUrl);
    }else{
      imageList.add(item!.imageFullUrl);
      imageList.addAll(item!.imagesFullUrl!);
    }

    return GetBuilder<ItemController>(builder: (itemController) {

      return Column(mainAxisSize: MainAxisSize.min, children: [

          InkWell(
            onTap: isCampaign ? null : () {
              if(!isCampaign) {
                Navigator.of(context).pushNamed(RouteHelper.getItemImagesRoute(item!), arguments: ItemImageViewWidget(item: item));
              }
            },
            child: Stack(children: [
              SizedBox(
                height: ResponsiveHelper.isDesktop(context)? 350: MediaQuery.of(context).size.width * 0.7,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: isCampaign ? imageListForCampaign.length : imageList.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomImage(
                        image: '${isCampaign ? imageListForCampaign[index] : imageList[index]}',
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    itemController.setImageSliderIndex(index);
                  },
                ),
              ),
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _indicators(context, itemController, isCampaign ? imageListForCampaign : imageList),
                  ),
                ),
              ),

            ]),
          ),

      ]);
    });
  }

  List<Widget> _indicators(BuildContext context, ItemController itemController, List<String?> imageList) {
    List<Widget> indicators = [];
    for (int index = 0; index < imageList.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index == itemController.imageSliderIndex ? Theme.of(context).primaryColor : Colors.white,
        borderColor: Colors.white,
        size: 10,
      ));
    }
    return indicators;
  }

}
