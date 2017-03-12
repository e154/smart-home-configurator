angular
.module('appServices')
.directive 'iframePreview', ['$compile', ($compile) ->
  restrict: 'EA'
  scope:
    content: "="
  link: ($scope, $element, $attrs) ->

    # http://htmlbook.ru/html/iframe
    iframe = document.createElement('iframe')
#    iframe.setAttribute('sandbox', 'allow-same-origin || allow-top-navigation || allow-forms || allow-scripts')
    iframe.setAttribute('scrolling', 'auto')
    iframe.setAttribute('seamless', '')
    iframe.setAttribute('frameborder', 'no')
    element0 = $element[0]

    element0.appendChild(iframe)
    body = iframe.contentDocument.body

    $scope.$watch 'content', ()->
      body.innerHTML = $scope.content


]