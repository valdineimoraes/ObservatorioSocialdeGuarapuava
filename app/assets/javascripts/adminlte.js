/*! AdminLTE app.js
* ================
* Main JS application file for AdminLTE v2. This file
* should be included in all pages. It controls some layout
* options and implements exclusive AdminLTE plugins.
*
* @Author  Almsaeed Studio
* @Support <https://www.almsaeedstudio.com>
* @Email   <abdullah@almsaeedstudio.com>
* @version 2.4.0
* @repository git://github.com/almasaeed2010/AdminLTE.git
* @license MIT <http://opensource.org/licenses/MIT>
*/

// Make sure jQuery has been loaded
document.addEventListener("turbolinks:load", function() {
  my_func();
})

if (typeof jQuery === 'undefined') {
    throw new Error('AdminLTE requires jQuery')
    }
    

    /* BoxRefresh()
     * =========
     * Adds AJAX content control to a box.
     *
     * @Usage: $('#my-box').boxRefresh(options)
     *         or add [data-widget="box-refresh"] to the box element
     *         Pass any option as data-option="value"
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.boxrefresh'
    
      var Default = {
        source         : '',
        params         : {},
        trigger        : '.refresh-btn',
        content        : '.box-body',
        loadInContent  : true,
        responseType   : '',
        overlayTemplate: '<div class="overlay"><div class="fa fa-refresh fa-spin"></div></div>',
        onLoadStart    : function () {
        },
        onLoadDone     : function (response) {
          return response
        }
      }
    
      var Selector = {
        data: '[data-widget="box-refresh"]'
      }
    
      // BoxRefresh Class Definition
      // =========================
      var BoxRefresh = function (element, options) {
        this.element  = element
        this.options  = options
        this.$overlay = $(options.overlay)
    
        if (options.source === '') {
          throw new Error('Source url was not defined. Please specify a url in your BoxRefresh source option.')
        }
    
        this._setUpListeners()
        this.load()
      }
    
      BoxRefresh.prototype.load = function () {
        this._addOverlay()
        this.options.onLoadStart.call($(this))
    
        $.get(this.options.source, this.options.params, function (response) {
          if (this.options.loadInContent) {
            $(this.options.content).html(response)
          }
          this.options.onLoadDone.call($(this), response)
          this._removeOverlay()
        }.bind(this), this.options.responseType !== '' && this.options.responseType)
      }
    
      // Private
    
      BoxRefresh.prototype._setUpListeners = function () {
        $(this.element).on('click', Selector.trigger, function (event) {
          if (event) event.preventDefault()
          this.load()
        }.bind(this))
      }
    
      BoxRefresh.prototype._addOverlay = function () {
        $(this.element).append(this.$overlay)
      }
    
      BoxRefresh.prototype._removeOverlay = function () {
        $(this.element).remove(this.$overlay)
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option == 'object' && option)
            $this.data(DataKey, (data = new BoxRefresh($this, options)))
          }
    
          if (typeof data == 'string') {
            if (typeof data[option] == 'undefined') {
              throw new Error('No method named ' + option)
            }
            data[option]()
          }
        })
      }
    
      var old = $.fn.boxRefresh
    
      $.fn.boxRefresh             = Plugin
      $.fn.boxRefresh.Constructor = BoxRefresh
    
      // No Conflict Mode
      // ================
      $.fn.boxRefresh.noConflict = function () {
        $.fn.boxRefresh = old
        return this
      }
    
      // BoxRefresh Data API
      // =================
      $(window).on('load', function () {
        $(Selector.data).each(function () {
          Plugin.call($(this))
        })
      })
    
    }(jQuery)
    
    
    /* BoxWidget()
     * ======
     * Adds box widget functions to boxes.
     *
     * @Usage: $('.my-box').boxWidget(options)
     *         This plugin auto activates on any element using the `.box` class
     *         Pass any option as data-option="value"
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.boxwidget'
    
      var Default = {
        animationSpeed : 500,
        collapseTrigger: '[data-widget="collapse"]',
        removeTrigger  : '[data-widget="remove"]',
        collapseIcon   : 'fa-minus',
        expandIcon     : 'fa-plus',
        removeIcon     : 'fa-times'
      }
    
      var Selector = {
        data     : '.box',
        collapsed: '.collapsed-box',
        body     : '.box-body',
        footer   : '.box-footer',
        tools    : '.box-tools'
      }
    
      var ClassName = {
        collapsed: 'collapsed-box'
      }
    
      var Event = {
        collapsed: 'collapsed.boxwidget',
        expanded : 'expanded.boxwidget',
        removed  : 'removed.boxwidget'
      }
    
      // BoxWidget Class Definition
      // =====================
      var BoxWidget = function (element, options) {
        this.element = element
        this.options = options
    
        this._setUpListeners()
      }
    
      BoxWidget.prototype.toggle = function () {
        var isOpen = !$(this.element).is(Selector.collapsed)
    
        if (isOpen) {
          this.collapse()
        } else {
          this.expand()
        }
      }
    
      BoxWidget.prototype.expand = function () {
        var expandedEvent = $.Event(Event.expanded)
        var collapseIcon  = this.options.collapseIcon
        var expandIcon    = this.options.expandIcon
    
        $(this.element).removeClass(ClassName.collapsed)
    
        $(this.element)
          .find(Selector.tools)
          .find('.' + expandIcon)
          .removeClass(expandIcon)
          .addClass(collapseIcon)
    
        $(this.element).find(Selector.body + ', ' + Selector.footer)
          .slideDown(this.options.animationSpeed, function () {
            $(this.element).trigger(expandedEvent)
          }.bind(this))
      }
    
      BoxWidget.prototype.collapse = function () {
        var collapsedEvent = $.Event(Event.collapsed)
        var collapseIcon   = this.options.collapseIcon
        var expandIcon     = this.options.expandIcon
    
        $(this.element)
          .find(Selector.tools)
          .find('.' + collapseIcon)
          .removeClass(collapseIcon)
          .addClass(expandIcon)
    
        $(this.element).find(Selector.body + ', ' + Selector.footer)
          .slideUp(this.options.animationSpeed, function () {
            $(this.element).addClass(ClassName.collapsed)
            $(this.element).trigger(collapsedEvent)
          }.bind(this))
      }
    
      BoxWidget.prototype.remove = function () {
        var removedEvent = $.Event(Event.removed)
    
        $(this.element).slideUp(this.options.animationSpeed, function () {
          $(this.element).trigger(removedEvent)
          $(this.element).remove()
        }.bind(this))
      }
    
      // Private
    
      BoxWidget.prototype._setUpListeners = function () {
        var that = this
    
        $(this.element).on('click', this.options.collapseTrigger, function (event) {
          if (event) event.preventDefault()
          that.toggle()
        })
    
        $(this.element).on('click', this.options.removeTrigger, function (event) {
          if (event) event.preventDefault()
          that.remove()
        })
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option == 'object' && option)
            $this.data(DataKey, (data = new BoxWidget($this, options)))
          }
    
          if (typeof option == 'string') {
            if (typeof data[option] == 'undefined') {
              throw new Error('No method named ' + option)
            }
            data[option]()
          }
        })
      }
    
      var old = $.fn.boxWidget
    
      $.fn.boxWidget             = Plugin
      $.fn.boxWidget.Constructor = BoxWidget
    
      // No Conflict Mode
      // ================
      $.fn.boxWidget.noConflict = function () {
        $.fn.boxWidget = old
        return this
      }
    
      // BoxWidget Data API
      // ==================
      $(window).on('load', function () {
        $(Selector.data).each(function () {
          Plugin.call($(this))
        })
      })
    
    }(jQuery)
    
    
    /* ControlSidebar()
     * ===============
     * Toggles the state of the control sidebar
     *
     * @Usage: $('#control-sidebar-trigger').controlSidebar(options)
     *         or add [data-toggle="control-sidebar"] to the trigger
     *         Pass any option as data-option="value"
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.controlsidebar'
    
      var Default = {
        slide: true
      }
    
      var Selector = {
        sidebar: '.control-sidebar',
        data   : '[data-toggle="control-sidebar"]',
        open   : '.control-sidebar-open',
        bg     : '.control-sidebar-bg',
        wrapper: '.wrapper',
        content: '.content-wrapper',
        boxed  : '.layout-boxed'
      }
    
      var ClassName = {
        open : 'control-sidebar-open',
        fixed: 'fixed'
      }
    
      var Event = {
        collapsed: 'collapsed.controlsidebar',
        expanded : 'expanded.controlsidebar'
      }
    
      // ControlSidebar Class Definition
      // ===============================
      var ControlSidebar = function (element, options) {
        this.element         = element
        this.options         = options
        this.hasBindedResize = false
    
        this.init()
      }
    
      ControlSidebar.prototype.init = function () {
        // Add click listener if the element hasn't been
        // initialized using the data API
        if (!$(this.element).is(Selector.data)) {
          $(this).on('click', this.toggle)
        }
    
        this.fix()
        $(window).resize(function () {
          this.fix()
        }.bind(this))
      }
    
      ControlSidebar.prototype.toggle = function (event) {
        if (event) event.preventDefault()
    
        this.fix()
    
        if (!$(Selector.sidebar).is(Selector.open) && !$('body').is(Selector.open)) {
          this.expand()
        } else {
          this.collapse()
        }
      }
    
      ControlSidebar.prototype.expand = function () {
        if (!this.options.slide) {
          $('body').addClass(ClassName.open)
        } else {
          $(Selector.sidebar).addClass(ClassName.open)
        }
    
        $(this.element).trigger($.Event(Event.expanded))
      }
    
      ControlSidebar.prototype.collapse = function () {
        $('body, ' + Selector.sidebar).removeClass(ClassName.open)
        $(this.element).trigger($.Event(Event.collapsed))
      }
    
      ControlSidebar.prototype.fix = function () {
        if ($('body').is(Selector.boxed)) {
          this._fixForBoxed($(Selector.bg))
        }
      }
    
      // Private
    
      ControlSidebar.prototype._fixForBoxed = function (bg) {
        bg.css({
          position: 'absolute',
          height  : $(Selector.wrapper).height()
        })
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option == 'object' && option)
            $this.data(DataKey, (data = new ControlSidebar($this, options)))
          }
    
          if (typeof option == 'string') data.toggle()
        })
      }
    
      var old = $.fn.controlSidebar
    
      $.fn.controlSidebar             = Plugin
      $.fn.controlSidebar.Constructor = ControlSidebar
    
      // No Conflict Mode
      // ================
      $.fn.controlSidebar.noConflict = function () {
        $.fn.controlSidebar = old
        return this
      }
    
      // ControlSidebar Data API
      // =======================
      $(document).on('click', Selector.data, function (event) {
        if (event) event.preventDefault()
        Plugin.call($(this), 'toggle')
      })
    
    }(jQuery)
    
    
    /* DirectChat()
     * ===============
     * Toggles the state of the control sidebar
     *
     * @Usage: $('#my-chat-box').directChat()
     *         or add [data-widget="direct-chat"] to the trigger
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.directchat'
    
      var Selector = {
        data: '[data-widget="chat-pane-toggle"]',
        box : '.direct-chat'
      }
    
      var ClassName = {
        open: 'direct-chat-contacts-open'
      }
    
      // DirectChat Class Definition
      // ===========================
      var DirectChat = function (element) {
        this.element = element
      }
    
      DirectChat.prototype.toggle = function ($trigger) {
        $trigger.parents(Selector.box).first().toggleClass(ClassName.open)
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            $this.data(DataKey, (data = new DirectChat($this)))
          }
    
          if (typeof option == 'string') data.toggle($this)
        })
      }
    
      var old = $.fn.directChat
    
      $.fn.directChat             = Plugin
      $.fn.directChat.Constructor = DirectChat
    
      // No Conflict Mode
      // ================
      $.fn.directChat.noConflict = function () {
        $.fn.directChat = old
        return this
      }
    
      // DirectChat Data API
      // ===================
      $(document).on('click', Selector.data, function (event) {
        if (event) event.preventDefault()
        Plugin.call($(this), 'toggle')
      })
    
    }(jQuery)
    
    
    /* Layout()
     * ========
     * Implements AdminLTE layout.
     * Fixes the layout height in case min-height fails.
     *
     * @usage activated automatically upon window load.
     *        Configure any options by passing data-option="value"
     *        to the body tag.
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.layout'
    
      var Default = {
        slimscroll : true,
        resetHeight: true
      }
    
      var Selector = {
        wrapper       : '.wrapper',
        contentWrapper: '.content-wrapper',
        layoutBoxed   : '.layout-boxed',
        mainFooter    : '.main-footer',
        mainHeader    : '.main-header',
        sidebar       : '.sidebar',
        controlSidebar: '.control-sidebar',
        fixed         : '.fixed',
        sidebarMenu   : '.sidebar-menu',
        logo          : '.main-header .logo'
      }
    
      var ClassName = {
        fixed         : 'fixed',
        holdTransition: 'hold-transition'
      }
    
      var Layout = function (options) {
        this.options      = options
        this.bindedResize = false
        this.activate()
      }
    
      Layout.prototype.activate = function () {
        this.fix()
        this.fixSidebar()
    
        $('body').removeClass(ClassName.holdTransition)
    
        if (this.options.resetHeight) {
          $('body, html, ' + Selector.wrapper).css({
            'height'    : 'auto',
            'min-height': '100%'
          })
        }
    
        if (!this.bindedResize) {
          $(window).resize(function () {
            this.fix()
            this.fixSidebar()
    
            $(Selector.logo + ', ' + Selector.sidebar).one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function () {
              this.fix()
              this.fixSidebar()
            }.bind(this))
          }.bind(this))
    
          this.bindedResize = true
        }
    
        $(Selector.sidebarMenu).on('expanded.tree', function () {
          this.fix()
          this.fixSidebar()
        }.bind(this))
    
        $(Selector.sidebarMenu).on('collapsed.tree', function () {
          this.fix()
          this.fixSidebar()
        }.bind(this))
      }
    
      Layout.prototype.fix = function () {
        // Remove overflow from .wrapper if layout-boxed exists
        $(Selector.layoutBoxed + ' > ' + Selector.wrapper).css('overflow', 'hidden')
    
        // Get window height and the wrapper height
        var footerHeight  = $(Selector.mainFooter).outerHeight() || 0
        var neg           = $(Selector.mainHeader).outerHeight() + footerHeight
        var windowHeight  = $(window).height()
        var sidebarHeight = $(Selector.sidebar).height() || 0
    
        // Set the min-height of the content and sidebar based on
        // the height of the document.
        if ($('body').hasClass(ClassName.fixed)) {
          $(Selector.contentWrapper).css('min-height', windowHeight - footerHeight)
        } else {
          var postSetHeight
    
          if (windowHeight >= sidebarHeight) {
            $(Selector.contentWrapper).css('min-height', windowHeight - neg)
            postSetHeight = windowHeight - neg
          } else {
            $(Selector.contentWrapper).css('min-height', sidebarHeight)
            postSetHeight = sidebarHeight
          }
    
          // Fix for the control sidebar height
          var $controlSidebar = $(Selector.controlSidebar)
          if (typeof $controlSidebar !== 'undefined') {
            if ($controlSidebar.height() > postSetHeight)
              $(Selector.contentWrapper).css('min-height', $controlSidebar.height())
          }
        }
      }
    
      Layout.prototype.fixSidebar = function () {
        // Make sure the body tag has the .fixed class
        if (!$('body').hasClass(ClassName.fixed)) {
          if (typeof $.fn.slimScroll !== 'undefined') {
            $(Selector.sidebar).slimScroll({ destroy: true }).height('auto')
          }
          return
        }
    
        // Enable slimscroll for fixed layout
        if (this.options.slimscroll) {
          if (typeof $.fn.slimScroll !== 'undefined') {
            // Destroy if it exists
            $(Selector.sidebar).slimScroll({ destroy: true }).height('auto')
    
            // Add slimscroll
            $(Selector.sidebar).slimScroll({
              height: ($(window).height() - $(Selector.mainHeader).height()) + 'px',
              color : 'rgba(0,0,0,0.2)',
              size  : '3px'
            })
          }
        }
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option === 'object' && option)
            $this.data(DataKey, (data = new Layout(options)))
          }
    
          if (typeof option === 'string') {
            if (typeof data[option] === 'undefined') {
              throw new Error('No method named ' + option)
            }
            data[option]()
          }
        })
      }
    
      var old = $.fn.layout
    
      $.fn.layout            = Plugin
      $.fn.layout.Constuctor = Layout
    
      // No conflict mode
      // ================
      $.fn.layout.noConflict = function () {
        $.fn.layout = old
        return this
      }
    
      // Layout DATA-API
      // ===============
      $(window).on('load', function () {
        Plugin.call($('body'))
      })
    }(jQuery)
    
    
    /* PushMenu()
     * ==========
     * Adds the push menu functionality to the sidebar.
     *
     * @usage: $('.btn').pushMenu(options)
     *          or add [data-toggle="push-menu"] to any button
     *          Pass any option as data-option="value"
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.pushmenu'
    
      var Default = {
        collapseScreenSize   : 767,
        expandOnHover        : false,
        expandTransitionDelay: 200
      }
    
      var Selector = {
        collapsed     : '.sidebar-collapse',
        open          : '.sidebar-open',
        mainSidebar   : '.main-sidebar',
        contentWrapper: '.content-wrapper',
        searchInput   : '.sidebar-form .form-control',
        button        : '[data-toggle="push-menu"]',
        mini          : '.sidebar-mini',
        expanded      : '.sidebar-expanded-on-hover',
        layoutFixed   : '.fixed'
      }
    
      var ClassName = {
        collapsed    : 'sidebar-collapse',
        open         : 'sidebar-open',
        mini         : 'sidebar-mini',
        expanded     : 'sidebar-expanded-on-hover',
        expandFeature: 'sidebar-mini-expand-feature',
        layoutFixed  : 'fixed'
      }
    
      var Event = {
        expanded : 'expanded.pushMenu',
        collapsed: 'collapsed.pushMenu'
      }
    
      // PushMenu Class Definition
      // =========================
      var PushMenu = function (options) {
        this.options = options
        this.init()
      }
    
      PushMenu.prototype.init = function () {
        if (this.options.expandOnHover
          || ($('body').is(Selector.mini + Selector.layoutFixed))) {
          this.expandOnHover()
          $('body').addClass(ClassName.expandFeature)
        }
    
        $(Selector.contentWrapper).click(function () {
          // Enable hide menu when clicking on the content-wrapper on small screens
          if ($(window).width() <= this.options.collapseScreenSize && $('body').hasClass(ClassName.open)) {
            this.close()
          }
        }.bind(this))
    
        // __Fix for android devices
        $(Selector.searchInput).click(function (e) {
          e.stopPropagation()
        })
      }
    
      PushMenu.prototype.toggle = function () {
        var windowWidth = $(window).width()
        var isOpen      = !$('body').hasClass(ClassName.collapsed)
    
        if (windowWidth <= this.options.collapseScreenSize) {
          isOpen = $('body').hasClass(ClassName.open)
        }
    
        if (!isOpen) {
          this.open()
        } else {
          this.close()
        }
      }
    
      PushMenu.prototype.open = function () {
        var windowWidth = $(window).width()
    
        if (windowWidth > this.options.collapseScreenSize) {
          $('body').removeClass(ClassName.collapsed)
            .trigger($.Event(Event.expanded))
        }
        else {
          $('body').addClass(ClassName.open)
            .trigger($.Event(Event.expanded))
        }
      }
    
      PushMenu.prototype.close = function () {
        var windowWidth = $(window).width()
        if (windowWidth > this.options.collapseScreenSize) {
          $('body').addClass(ClassName.collapsed)
            .trigger($.Event(Event.collapsed))
        } else {
          $('body').removeClass(ClassName.open + ' ' + ClassName.collapsed)
            .trigger($.Event(Event.collapsed))
        }
      }
    
      PushMenu.prototype.expandOnHover = function () {
        $(Selector.mainSidebar).hover(function () {
          if ($('body').is(Selector.mini + Selector.collapsed)
            && $(window).width() > this.options.collapseScreenSize) {
            this.expand()
          }
        }.bind(this), function () {
          if ($('body').is(Selector.expanded)) {
            this.collapse()
          }
        }.bind(this))
      }
    
      PushMenu.prototype.expand = function () {
        setTimeout(function () {
          $('body').removeClass(ClassName.collapsed)
            .addClass(ClassName.expanded)
        }, this.options.expandTransitionDelay)
      }
    
      PushMenu.prototype.collapse = function () {
        setTimeout(function () {
          $('body').removeClass(ClassName.expanded)
            .addClass(ClassName.collapsed)
        }, this.options.expandTransitionDelay)
      }
    
      // PushMenu Plugin Definition
      // ==========================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option == 'object' && option)
            $this.data(DataKey, (data = new PushMenu(options)))
          }
    
          if (option == 'toggle') data.toggle()
        })
      }
    
      var old = $.fn.pushMenu
    
      $.fn.pushMenu             = Plugin
      $.fn.pushMenu.Constructor = PushMenu
    
      // No Conflict Mode
      // ================
      $.fn.pushMenu.noConflict = function () {
        $.fn.pushMenu = old
        return this
      }
    
      // Data API
      // ========
      $(document).on('click', Selector.button, function (e) {
        e.preventDefault()
        Plugin.call($(this), 'toggle')
      })
      $(window).on('load', function () {
        Plugin.call($(Selector.button))
      })
    }(jQuery)
    
    
    /* TodoList()
     * =========
     * Converts a list into a todoList.
     *
     * @Usage: $('.my-list').todoList(options)
     *         or add [data-widget="todo-list"] to the ul element
     *         Pass any option as data-option="value"
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.todolist'
    
      var Default = {
        onCheck  : function (item) {
          return item
        },
        onUnCheck: function (item) {
          return item
        }
      }
    
      var Selector = {
        data: '[data-widget="todo-list"]'
      }
    
      var ClassName = {
        done: 'done'
      }
    
      // TodoList Class Definition
      // =========================
      var TodoList = function (element, options) {
        this.element = element
        this.options = options
    
        this._setUpListeners()
      }
    
      TodoList.prototype.toggle = function (item) {
        item.parents(Selector.li).first().toggleClass(ClassName.done)
        if (!item.prop('checked')) {
          this.unCheck(item)
          return
        }
    
        this.check(item)
      }
    
      TodoList.prototype.check = function (item) {
        this.options.onCheck.call(item)
      }
    
      TodoList.prototype.unCheck = function (item) {
        this.options.onUnCheck.call(item)
      }
    
      // Private
    
      TodoList.prototype._setUpListeners = function () {
        var that = this
        $(this.element).on('change ifChanged', 'input:checkbox', function () {
          that.toggle($(this))
        })
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option == 'object' && option)
            $this.data(DataKey, (data = new TodoList($this, options)))
          }
    
          if (typeof data == 'string') {
            if (typeof data[option] == 'undefined') {
              throw new Error('No method named ' + option)
            }
            data[option]()
          }
        })
      }
    
      var old = $.fn.todoList
    
      $.fn.todoList         = Plugin
      $.fn.todoList.Constructor = TodoList
    
      // No Conflict Mode
      // ================
      $.fn.todoList.noConflict = function () {
        $.fn.todoList = old
        return this
      }
    
      // TodoList Data API
      // =================
      $(window).on('load', function () {
        $(Selector.data).each(function () {
          Plugin.call($(this))
        })
      })
    
    }(jQuery)
    
    
    /* Tree()
     * ======
     * Converts a nested list into a multilevel
     * tree view menu.
     *
     * @Usage: $('.my-menu').tree(options)
     *         or add [data-widget="tree"] to the ul element
     *         Pass any option as data-option="value"
     */
    +function ($) {
      'use strict'
    
      var DataKey = 'lte.tree'
    
      var Default = {
        animationSpeed: 500,
        accordion     : true,
        followLink    : false,
        trigger       : '.treeview a'
      }
    
      var Selector = {
        tree        : '.tree',
        treeview    : '.treeview',
        treeviewMenu: '.treeview-menu',
        open        : '.menu-open, .active',
        li          : 'li',
        data        : '[data-widget="tree"]',
        active      : '.active'
      }
    
      var ClassName = {
        open: 'menu-open',
        tree: 'tree'
      }
    
      var Event = {
        collapsed: 'collapsed.tree',
        expanded : 'expanded.tree'
      }
    
      // Tree Class Definition
      // =====================
      var Tree = function (element, options) {
        this.element = element
        this.options = options
    
        $(this.element).addClass(ClassName.tree)
    
        $(Selector.treeview + Selector.active, this.element).addClass(ClassName.open)
    
        this._setUpListeners()
      }
    
      Tree.prototype.toggle = function (link, event) {
        var treeviewMenu = link.next(Selector.treeviewMenu)
        var parentLi     = link.parent()
        var isOpen       = parentLi.hasClass(ClassName.open)
    
        if (!parentLi.is(Selector.treeview)) {
          return
        }
    
        if (!this.options.followLink || link.attr('href') == '#') {
          event.preventDefault()
        }
    
        if (isOpen) {
          this.collapse(treeviewMenu, parentLi)
        } else {
          this.expand(treeviewMenu, parentLi)
        }
      }
    
      Tree.prototype.expand = function (tree, parent) {
        var expandedEvent = $.Event(Event.expanded)
    
        if (this.options.accordion) {
          var openMenuLi = parent.siblings(Selector.open)
          var openTree   = openMenuLi.children(Selector.treeviewMenu)
          this.collapse(openTree, openMenuLi)
        }
    
        parent.addClass(ClassName.open)
        tree.slideDown(this.options.animationSpeed, function () {
          $(this.element).trigger(expandedEvent)
        }.bind(this))
      }
    
      Tree.prototype.collapse = function (tree, parentLi) {
        var collapsedEvent = $.Event(Event.collapsed)
    
        tree.find(Selector.open).removeClass(ClassName.open)
        parentLi.removeClass(ClassName.open)
        tree.slideUp(this.options.animationSpeed, function () {
          tree.find(Selector.open + ' > ' + Selector.treeview).slideUp()
          $(this.element).trigger(collapsedEvent)
        }.bind(this))
      }
    
      // Private
    
      Tree.prototype._setUpListeners = function () {
        var that = this
    
        $(this.element).on('click', this.options.trigger, function (event) {
          that.toggle($(this), event)
        })
      }
    
      // Plugin Definition
      // =================
      function Plugin(option) {
        return this.each(function () {
          var $this = $(this)
          var data  = $this.data(DataKey)
    
          if (!data) {
            var options = $.extend({}, Default, $this.data(), typeof option == 'object' && option)
            $this.data(DataKey, new Tree($this, options))
          }
        })
      }
    
      var old = $.fn.tree
    
      $.fn.tree             = Plugin
      $.fn.tree.Constructor = Tree
    
      // No Conflict Mode
      // ================
      $.fn.tree.noConflict = function () {
        $.fn.tree = old
        return this
      }
    
      // Tree Data API
      // =============
      $(window).on('load', function () {
        $(Selector.data).each(function () {
          Plugin.call($(this))
        })
      })
    
    }(jQuery)

/*! AdminLTE app.js
* ================
* Main JS application file for AdminLTE v2. This file
* should be included in all pages. It controls some layout
* options and implements exclusive AdminLTE plugins.
*
* @Author  Almsaeed Studio
* @Support <https://www.almsaeedstudio.com>
* @Email   <abdullah@almsaeedstudio.com>
* @version 2.4.7
* @repository git://github.com/almasaeed2010/AdminLTE.git
* @license MIT <http://opensource.org/licenses/MIT>
*/
if("undefined"==typeof jQuery)throw new Error("AdminLTE requires jQuery");+function(a){"use strict";function b(b){return this.each(function(){var e=a(this),g=e.data(c);if(!g){var h=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,g=new f(e,h))}if("string"==typeof g){if(void 0===g[b])throw new Error("No method named "+b);g[b]()}})}var c="lte.boxrefresh",d={source:"",params:{},trigger:".refresh-btn",content:".box-body",loadInContent:!0,responseType:"",overlayTemplate:'<div class="overlay"><div class="fa fa-refresh fa-spin"></div></div>',onLoadStart:function(){},onLoadDone:function(a){return a}},e={data:'[data-widget="box-refresh"]'},f=function(b,c){if(this.element=b,this.options=c,this.$overlay=a(c.overlay),""===c.source)throw new Error("Source url was not defined. Please specify a url in your BoxRefresh source option.");this._setUpListeners(),this.load()};f.prototype.load=function(){this._addOverlay(),this.options.onLoadStart.call(a(this)),a.get(this.options.source,this.options.params,function(b){this.options.loadInContent&&a(this.options.content).html(b),this.options.onLoadDone.call(a(this),b),this._removeOverlay()}.bind(this),""!==this.options.responseType&&this.options.responseType)},f.prototype._setUpListeners=function(){a(this.element).on("click",e.trigger,function(a){a&&a.preventDefault(),this.load()}.bind(this))},f.prototype._addOverlay=function(){a(this.element).append(this.$overlay)},f.prototype._removeOverlay=function(){a(this.element).remove(this.$overlay)};var g=a.fn.boxRefresh;a.fn.boxRefresh=b,a.fn.boxRefresh.Constructor=f,a.fn.boxRefresh.noConflict=function(){return a.fn.boxRefresh=g,this},a(window).on("load",function(){a(e.data).each(function(){b.call(a(this))})})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var e=a(this),f=e.data(c);if(!f){var g=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,f=new h(e,g))}if("string"==typeof b){if(void 0===f[b])throw new Error("No method named "+b);f[b]()}})}var c="lte.boxwidget",d={animationSpeed:500,collapseTrigger:'[data-widget="collapse"]',removeTrigger:'[data-widget="remove"]',collapseIcon:"fa-minus",expandIcon:"fa-plus",removeIcon:"fa-times"},e={data:".box",collapsed:".collapsed-box",header:".box-header",body:".box-body",footer:".box-footer",tools:".box-tools"},f={collapsed:"collapsed-box"},g={collapsed:"collapsed.boxwidget",expanded:"expanded.boxwidget",removed:"removed.boxwidget"},h=function(a,b){this.element=a,this.options=b,this._setUpListeners()};h.prototype.toggle=function(){a(this.element).is(e.collapsed)?this.expand():this.collapse()},h.prototype.expand=function(){var b=a.Event(g.expanded),c=this.options.collapseIcon,d=this.options.expandIcon;a(this.element).removeClass(f.collapsed),a(this.element).children(e.header+", "+e.body+", "+e.footer).children(e.tools).find("."+d).removeClass(d).addClass(c),a(this.element).children(e.body+", "+e.footer).slideDown(this.options.animationSpeed,function(){a(this.element).trigger(b)}.bind(this))},h.prototype.collapse=function(){var b=a.Event(g.collapsed),c=this.options.collapseIcon,d=this.options.expandIcon;a(this.element).children(e.header+", "+e.body+", "+e.footer).children(e.tools).find("."+c).removeClass(c).addClass(d),a(this.element).children(e.body+", "+e.footer).slideUp(this.options.animationSpeed,function(){a(this.element).addClass(f.collapsed),a(this.element).trigger(b)}.bind(this))},h.prototype.remove=function(){var b=a.Event(g.removed);a(this.element).slideUp(this.options.animationSpeed,function(){a(this.element).trigger(b),a(this.element).remove()}.bind(this))},h.prototype._setUpListeners=function(){var b=this;a(this.element).on("click",this.options.collapseTrigger,function(c){return c&&c.preventDefault(),b.toggle(a(this)),!1}),a(this.element).on("click",this.options.removeTrigger,function(c){return c&&c.preventDefault(),b.remove(a(this)),!1})};var i=a.fn.boxWidget;a.fn.boxWidget=b,a.fn.boxWidget.Constructor=h,a.fn.boxWidget.noConflict=function(){return a.fn.boxWidget=i,this},a(window).on("load",function(){a(e.data).each(function(){b.call(a(this))})})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var e=a(this),f=e.data(c);if(!f){var g=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,f=new h(e,g))}"string"==typeof b&&f.toggle()})}var c="lte.controlsidebar",d={slide:!0},e={sidebar:".control-sidebar",data:'[data-toggle="control-sidebar"]',open:".control-sidebar-open",bg:".control-sidebar-bg",wrapper:".wrapper",content:".content-wrapper",boxed:".layout-boxed"},f={open:"control-sidebar-open",fixed:"fixed"},g={collapsed:"collapsed.controlsidebar",expanded:"expanded.controlsidebar"},h=function(a,b){this.element=a,this.options=b,this.hasBindedResize=!1,this.init()};h.prototype.init=function(){a(this.element).is(e.data)||a(this).on("click",this.toggle),this.fix(),a(window).resize(function(){this.fix()}.bind(this))},h.prototype.toggle=function(b){b&&b.preventDefault(),this.fix(),a(e.sidebar).is(e.open)||a("body").is(e.open)?this.collapse():this.expand()},h.prototype.expand=function(){this.options.slide?a(e.sidebar).addClass(f.open):a("body").addClass(f.open),a(this.element).trigger(a.Event(g.expanded))},h.prototype.collapse=function(){a("body, "+e.sidebar).removeClass(f.open),a(this.element).trigger(a.Event(g.collapsed))},h.prototype.fix=function(){a("body").is(e.boxed)&&this._fixForBoxed(a(e.bg))},h.prototype._fixForBoxed=function(b){b.css({position:"absolute",height:a(e.wrapper).height()})};var i=a.fn.controlSidebar;a.fn.controlSidebar=b,a.fn.controlSidebar.Constructor=h,a.fn.controlSidebar.noConflict=function(){return a.fn.controlSidebar=i,this},a(document).on("click",e.data,function(c){c&&c.preventDefault(),b.call(a(this),"toggle")})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var d=a(this),e=d.data(c);e||d.data(c,e=new f(d)),"string"==typeof b&&e.toggle(d)})}var c="lte.directchat",d={data:'[data-widget="chat-pane-toggle"]',box:".direct-chat"},e={open:"direct-chat-contacts-open"},f=function(a){this.element=a};f.prototype.toggle=function(a){a.parents(d.box).first().toggleClass(e.open)};var g=a.fn.directChat;a.fn.directChat=b,a.fn.directChat.Constructor=f,a.fn.directChat.noConflict=function(){return a.fn.directChat=g,this},a(document).on("click",d.data,function(c){c&&c.preventDefault(),b.call(a(this),"toggle")})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var e=a(this),f=e.data(c);if(!f){var h=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,f=new g(h))}if("string"==typeof b){if(void 0===f[b])throw new Error("No method named "+b);f[b]()}})}var c="lte.layout",d={slimscroll:!0,resetHeight:!0},e={wrapper:".wrapper",contentWrapper:".content-wrapper",layoutBoxed:".layout-boxed",mainFooter:".main-footer",mainHeader:".main-header",sidebar:".sidebar",controlSidebar:".control-sidebar",fixed:".fixed",sidebarMenu:".sidebar-menu",logo:".main-header .logo"},f={fixed:"fixed",holdTransition:"hold-transition"},g=function(a){this.options=a,this.bindedResize=!1,this.activate()};g.prototype.activate=function(){this.fix(),this.fixSidebar(),a("body").removeClass(f.holdTransition),this.options.resetHeight&&a("body, html, "+e.wrapper).css({height:"auto","min-height":"100%"}),this.bindedResize||(a(window).resize(function(){this.fix(),this.fixSidebar(),a(e.logo+", "+e.sidebar).one("webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend",function(){this.fix(),this.fixSidebar()}.bind(this))}.bind(this)),this.bindedResize=!0),a(e.sidebarMenu).on("expanded.tree",function(){this.fix(),this.fixSidebar()}.bind(this)),a(e.sidebarMenu).on("collapsed.tree",function(){this.fix(),this.fixSidebar()}.bind(this))},g.prototype.fix=function(){a(e.layoutBoxed+" > "+e.wrapper).css("overflow","hidden");var b=a(e.mainFooter).outerHeight()||0,c=a(e.mainHeader).outerHeight()||0,d=c+b,g=a(window).height(),h=a(e.sidebar).height()||0;if(a("body").hasClass(f.fixed))a(e.contentWrapper).css("min-height",g-b);else{var i;g>=h?(a(e.contentWrapper).css("min-height",g-d),i=g-d):(a(e.contentWrapper).css("min-height",h),i=h);var j=a(e.controlSidebar);void 0!==j&&j.height()>i&&a(e.contentWrapper).css("min-height",j.height())}},g.prototype.fixSidebar=function(){if(!a("body").hasClass(f.fixed))return void(void 0!==a.fn.slimScroll&&a(e.sidebar).slimScroll({destroy:!0}).height("auto"));this.options.slimscroll&&void 0!==a.fn.slimScroll&&a(e.sidebar).slimScroll({height:a(window).height()-a(e.mainHeader).height()+"px"})};var h=a.fn.layout;a.fn.layout=b,a.fn.layout.Constuctor=g,a.fn.layout.noConflict=function(){return a.fn.layout=h,this},a(window).on("load",function(){b.call(a("body"))})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var e=a(this),f=e.data(c);if(!f){var g=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,f=new h(g))}"toggle"===b&&f.toggle()})}var c="lte.pushmenu",d={collapseScreenSize:767,expandOnHover:!1,expandTransitionDelay:200},e={collapsed:".sidebar-collapse",open:".sidebar-open",mainSidebar:".main-sidebar",contentWrapper:".content-wrapper",searchInput:".sidebar-form .form-control",button:'[data-toggle="push-menu"]',mini:".sidebar-mini",expanded:".sidebar-expanded-on-hover",layoutFixed:".fixed"},f={collapsed:"sidebar-collapse",open:"sidebar-open",mini:"sidebar-mini",expanded:"sidebar-expanded-on-hover",expandFeature:"sidebar-mini-expand-feature",layoutFixed:"fixed"},g={expanded:"expanded.pushMenu",collapsed:"collapsed.pushMenu"},h=function(a){this.options=a,this.init()};h.prototype.init=function(){(this.options.expandOnHover||a("body").is(e.mini+e.layoutFixed))&&(this.expandOnHover(),a("body").addClass(f.expandFeature)),a(e.contentWrapper).click(function(){a(window).width()<=this.options.collapseScreenSize&&a("body").hasClass(f.open)&&this.close()}.bind(this)),a(e.searchInput).click(function(a){a.stopPropagation()})},h.prototype.toggle=function(){var b=a(window).width(),c=!a("body").hasClass(f.collapsed);b<=this.options.collapseScreenSize&&(c=a("body").hasClass(f.open)),c?this.close():this.open()},h.prototype.open=function(){a(window).width()>this.options.collapseScreenSize?a("body").removeClass(f.collapsed).trigger(a.Event(g.expanded)):a("body").addClass(f.open).trigger(a.Event(g.expanded))},h.prototype.close=function(){a(window).width()>this.options.collapseScreenSize?a("body").addClass(f.collapsed).trigger(a.Event(g.collapsed)):a("body").removeClass(f.open+" "+f.collapsed).trigger(a.Event(g.collapsed))},h.prototype.expandOnHover=function(){a(e.mainSidebar).hover(function(){a("body").is(e.mini+e.collapsed)&&a(window).width()>this.options.collapseScreenSize&&this.expand()}.bind(this),function(){a("body").is(e.expanded)&&this.collapse()}.bind(this))},h.prototype.expand=function(){setTimeout(function(){a("body").removeClass(f.collapsed).addClass(f.expanded)},this.options.expandTransitionDelay)},h.prototype.collapse=function(){setTimeout(function(){a("body").removeClass(f.expanded).addClass(f.collapsed)},this.options.expandTransitionDelay)};var i=a.fn.pushMenu;a.fn.pushMenu=b,a.fn.pushMenu.Constructor=h,a.fn.pushMenu.noConflict=function(){return a.fn.pushMenu=i,this},a(document).on("click",e.button,function(c){c.preventDefault(),b.call(a(this),"toggle")}),a(window).on("load",function(){b.call(a(e.button))})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var e=a(this),f=e.data(c);if(!f){var h=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,f=new g(e,h))}if("string"==typeof f){if(void 0===f[b])throw new Error("No method named "+b);f[b]()}})}var c="lte.todolist",d={onCheck:function(a){return a},onUnCheck:function(a){return a}},e={data:'[data-widget="todo-list"]'},f={done:"done"},g=function(a,b){this.element=a,this.options=b,this._setUpListeners()};g.prototype.toggle=function(a){if(a.parents(e.li).first().toggleClass(f.done),!a.prop("checked"))return void this.unCheck(a);this.check(a)},g.prototype.check=function(a){this.options.onCheck.call(a)},g.prototype.unCheck=function(a){this.options.onUnCheck.call(a)},g.prototype._setUpListeners=function(){var b=this;a(this.element).on("change ifChanged","input:checkbox",function(){b.toggle(a(this))})};var h=a.fn.todoList;a.fn.todoList=b,a.fn.todoList.Constructor=g,a.fn.todoList.noConflict=function(){return a.fn.todoList=h,this},a(window).on("load",function(){a(e.data).each(function(){b.call(a(this))})})}(jQuery),function(a){"use strict";function b(b){return this.each(function(){var e=a(this);if(!e.data(c)){var f=a.extend({},d,e.data(),"object"==typeof b&&b);e.data(c,new h(e,f))}})}var c="lte.tree",d={animationSpeed:500,accordion:!0,followLink:!1,trigger:".treeview a"},e={tree:".tree",treeview:".treeview",treeviewMenu:".treeview-menu",open:".menu-open, .active",li:"li",data:'[data-widget="tree"]',active:".active"},f={open:"menu-open",tree:"tree"},g={collapsed:"collapsed.tree",expanded:"expanded.tree"},h=function(b,c){this.element=b,this.options=c,a(this.element).addClass(f.tree),a(e.treeview+e.active,this.element).addClass(f.open),this._setUpListeners()};h.prototype.toggle=function(a,b){var c=a.next(e.treeviewMenu),d=a.parent(),g=d.hasClass(f.open);d.is(e.treeview)&&(this.options.followLink&&"#"!==a.attr("href")||b.preventDefault(),g?this.collapse(c,d):this.expand(c,d))},h.prototype.expand=function(b,c){var d=a.Event(g.expanded);if(this.options.accordion){var h=c.siblings(e.open),i=h.children(e.treeviewMenu);this.collapse(i,h)}c.addClass(f.open),b.slideDown(this.options.animationSpeed,function(){a(this.element).trigger(d)}.bind(this))},h.prototype.collapse=function(b,c){var d=a.Event(g.collapsed);c.removeClass(f.open),b.slideUp(this.options.animationSpeed,function(){a(this.element).trigger(d)}.bind(this))},h.prototype._setUpListeners=function(){var b=this;a(this.element).on("click",this.options.trigger,function(c){b.toggle(a(this),c)})};var i=a.fn.tree;a.fn.tree=b,a.fn.tree.Constructor=h,a.fn.tree.noConflict=function(){return a.fn.tree=i,this},a(window).on("load",function(){a(e.data).each(function(){b.call(a(this))})})}(jQuery);
