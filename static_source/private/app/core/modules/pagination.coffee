###
# angular-ui-bootstrap
# http://angular-ui.github.io/bootstrap/

# Version: 2.5.0 - 2017-01-28
# License: MIT
###

angular.module('ui.bootstrap.pagination', [
  'uib/template/pagination/pagination.html'
  'ui.bootstrap.paging'
  'ui.bootstrap.tabindex'
]).controller('UibPaginationController', [
  '$scope'
  '$attrs'
  '$parse'
  'uibPaging'
  'uibPaginationConfig'
  ($scope, $attrs, $parse, uibPaging, uibPaginationConfig) ->
    ctrl = this
    # Setup configuration parameters
    maxSize = if angular.isDefined($attrs.maxSize) then $scope.$parent.$eval($attrs.maxSize) else uibPaginationConfig.maxSize
    rotate = if angular.isDefined($attrs.rotate) then $scope.$parent.$eval($attrs.rotate) else uibPaginationConfig.rotate
    forceEllipses = if angular.isDefined($attrs.forceEllipses) then $scope.$parent.$eval($attrs.forceEllipses) else uibPaginationConfig.forceEllipses
    boundaryLinkNumbers = if angular.isDefined($attrs.boundaryLinkNumbers) then $scope.$parent.$eval($attrs.boundaryLinkNumbers) else uibPaginationConfig.boundaryLinkNumbers
    pageLabel = if angular.isDefined($attrs.pageLabel) then ((idx) ->
      $scope.$parent.$eval $attrs.pageLabel, $page: idx
    ) else angular.identity
    # Create page object used in template

    makePage = (number, text, isActive) ->
      {
        number: number
        text: text
        active: isActive
      }

    getPages = (currentPage, totalPages) ->
      pages = []
      # Default page limits
      startPage = 1
      endPage = totalPages
      isMaxSized = angular.isDefined(maxSize) and maxSize < totalPages
      # recompute if maxSize
      if isMaxSized
        if rotate
# Current page is displayed in the middle of the visible ones
          startPage = Math.max(currentPage - Math.floor(maxSize / 2), 1)
          endPage = startPage + maxSize - 1
          # Adjust if limit is exceeded
          if endPage > totalPages
            endPage = totalPages
            startPage = endPage - maxSize + 1
        else
# Visible pages are paginated with maxSize
          startPage = (Math.ceil(currentPage / maxSize) - 1) * maxSize + 1
          # Adjust last page if limit is exceeded
          endPage = Math.min(startPage + maxSize - 1, totalPages)
      # Add page number links
      number = startPage
      while number <= endPage
        page = makePage(number, pageLabel(number), number == currentPage)
        pages.push page
        number++
      # Add links to move between page sets
      if isMaxSized and maxSize > 0 and (!rotate or forceEllipses or boundaryLinkNumbers)
        if startPage > 1
          if !boundaryLinkNumbers or startPage > 3
#need ellipsis for all options unless range is too close to beginning
            previousPageSet = makePage(startPage - 1, '...', false)
            pages.unshift previousPageSet
          if boundaryLinkNumbers
            if startPage == 3
#need to replace ellipsis when the buttons would be sequential
              secondPageLink = makePage(2, '2', false)
              pages.unshift secondPageLink
            #add the first page
            firstPageLink = makePage(1, '1', false)
            pages.unshift firstPageLink
        if endPage < totalPages
          if !boundaryLinkNumbers or endPage < totalPages - 2
#need ellipsis for all options unless range is too close to end
            nextPageSet = makePage(endPage + 1, '...', false)
            pages.push nextPageSet
          if boundaryLinkNumbers
            if endPage == totalPages - 2
#need to replace ellipsis when the buttons would be sequential
              secondToLastPageLink = makePage(totalPages - 1, totalPages - 1, false)
              pages.push secondToLastPageLink
            #add the last page
            lastPageLink = makePage(totalPages, totalPages, false)
            pages.push lastPageLink
      pages

    $scope.boundaryLinks = if angular.isDefined($attrs.boundaryLinks) then $scope.$parent.$eval($attrs.boundaryLinks) else uibPaginationConfig.boundaryLinks
    $scope.directionLinks = if angular.isDefined($attrs.directionLinks) then $scope.$parent.$eval($attrs.directionLinks) else uibPaginationConfig.directionLinks
    $attrs.$set 'role', 'menu'
    uibPaging.create this, $scope, $attrs
    if $attrs.maxSize
      ctrl._watchers.push $scope.$parent.$watch($parse($attrs.maxSize), (value) ->
        maxSize = parseInt(value, 10)
        ctrl.render()
        return
      )
    originalRender = @render

    @render = ->
      originalRender()
      if $scope.page > 0 and $scope.page <= $scope.totalPages
        $scope.pages = getPages($scope.page, $scope.totalPages)
      return

    return
]).constant('uibPaginationConfig',
  itemsPerPage: 10
  boundaryLinks: false
  boundaryLinkNumbers: false
  directionLinks: true
  firstText: 'First'
  previousText: 'Previous'
  nextText: 'Next'
  lastText: 'Last'
  rotate: true
  forceEllipses: false).directive 'uibPagination', [
  '$parse'
  'uibPaginationConfig'
  ($parse, uibPaginationConfig) ->
    {
      scope:
        totalItems: '='
        firstText: '@'
        previousText: '@'
        nextText: '@'
        lastText: '@'
        ngDisabled: '='
      require: [
        'uibPagination'
        '?ngModel'
      ]
      restrict: 'A'
      controller: 'UibPaginationController'
      controllerAs: 'pagination'
      templateUrl: (element, attrs) ->
        attrs.templateUrl or 'uib/template/pagination/pagination.html'
      link: (scope, element, attrs, ctrls) ->
        element.addClass 'pagination'
        paginationCtrl = ctrls[0]
        ngModelCtrl = ctrls[1]
        if !ngModelCtrl
          return
        # do nothing if no ng-model
        paginationCtrl.init ngModelCtrl, uibPaginationConfig
        return

    }
]
angular.module('ui.bootstrap.paging', []).factory 'uibPaging', [
  '$parse'
  ($parse) ->
    { create: (ctrl, $scope, $attrs) ->
      ctrl.setNumPages = if $attrs.numPages then $parse($attrs.numPages).assign else angular.noop
      ctrl.ngModelCtrl = $setViewValue: angular.noop
      # nullModelCtrl
      ctrl._watchers = []

      ctrl.init = (ngModelCtrl, config) ->
        ctrl.ngModelCtrl = ngModelCtrl
        ctrl.config = config

        ngModelCtrl.$render = ->
          ctrl.render()
          return

        if $attrs.itemsPerPage
          ctrl._watchers.push $scope.$parent.$watch($attrs.itemsPerPage, (value) ->
            ctrl.itemsPerPage = parseInt(value, 10)
            $scope.totalPages = ctrl.calculateTotalPages()
            ctrl.updatePage()
            return
          )
        else
          ctrl.itemsPerPage = config.itemsPerPage
        $scope.$watch 'totalItems', (newTotal, oldTotal) ->
          if angular.isDefined(newTotal) or newTotal != oldTotal
            $scope.totalPages = ctrl.calculateTotalPages()
            ctrl.updatePage()
          return
        return

      ctrl.calculateTotalPages = ->
        totalPages = if ctrl.itemsPerPage < 1 then 1 else Math.ceil($scope.totalItems / ctrl.itemsPerPage)
        Math.max totalPages or 0, 1

      ctrl.render = ->
        $scope.page = parseInt(ctrl.ngModelCtrl.$viewValue, 10) or 1
        return

      $scope.selectPage = (page, evt) ->
        if evt
          evt.preventDefault()
        clickAllowed = !$scope.ngDisabled or !evt
        if clickAllowed and $scope.page != page and page > 0 and page <= $scope.totalPages
          if evt and evt.target
            evt.target.blur()
          ctrl.ngModelCtrl.$setViewValue page
          ctrl.ngModelCtrl.$render()
        return

      $scope.getText = (key) ->
        $scope[key + 'Text'] or ctrl.config[key + 'Text']

      $scope.noPrevious = ->
        $scope.page == 1

      $scope.noNext = ->
        $scope.page == $scope.totalPages

      ctrl.updatePage = ->
        ctrl.setNumPages $scope.$parent, $scope.totalPages
        # Readonly variable
        if $scope.page > $scope.totalPages
          $scope.selectPage $scope.totalPages
        else
          ctrl.ngModelCtrl.$render()
        return

      $scope.$on '$destroy', ->
        while ctrl._watchers.length
          ctrl._watchers.shift()()
        return
      return
    }
]
angular.module('ui.bootstrap.tabindex', []).directive 'uibTabindexToggle', ->
  {
    restrict: 'A'
    link: (scope, elem, attrs) ->
      attrs.$observe 'disabled', (disabled) ->
        attrs.$set 'tabindex', if disabled then -1 else null
        return
      return

  }
angular.module('uib/template/pagination/pagination.html', []).run [
  '$templateCache'
  ($templateCache) ->
    $templateCache.put 'uib/template/pagination/pagination.html', '<li role="menuitem" ng-if="::boundaryLinks" ng-class="{disabled: noPrevious()||ngDisabled}" class="pagination-first"><a href ng-click="selectPage(1, $event)" ng-disabled="noPrevious()||ngDisabled" uib-tabindex-toggle>{{::getText(\'first\')}}</a></li>\n' + '<li role="menuitem" ng-if="::directionLinks" ng-class="{disabled: noPrevious()||ngDisabled}" class="pagination-prev"><a href ng-click="selectPage(page - 1, $event)" ng-disabled="noPrevious()||ngDisabled" uib-tabindex-toggle>{{::getText(\'previous\')}}</a></li>\n' + '<li role="menuitem" ng-repeat="page in pages track by $index" ng-class="{active: page.active,disabled: ngDisabled&&!page.active}" class="pagination-page"><a href ng-click="selectPage(page.number, $event)" ng-disabled="ngDisabled&&!page.active" uib-tabindex-toggle>{{page.text}}</a></li>\n' + '<li role="menuitem" ng-if="::directionLinks" ng-class="{disabled: noNext()||ngDisabled}" class="pagination-next"><a href ng-click="selectPage(page + 1, $event)" ng-disabled="noNext()||ngDisabled" uib-tabindex-toggle>{{::getText(\'next\')}}</a></li>\n' + '<li role="menuitem" ng-if="::boundaryLinks" ng-class="{disabled: noNext()||ngDisabled}" class="pagination-last"><a href ng-click="selectPage(totalPages, $event)" ng-disabled="noNext()||ngDisabled" uib-tabindex-toggle>{{::getText(\'last\')}}</a></li>\n' + ''
    return
]

# ---
# generated by js2coffee 2.2.0