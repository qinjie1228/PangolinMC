function changeContentImgSize(id){
	var aImg=document.getElementById(id).getElementsByTagName('img');
	for(var i=0;i<aImg.length;i++){
	      aImg[i].style.height=300+"px";
	      aImg[i].style.width=450+"px";
	}
}

